require 'spec_helper'

#RSpec.describe User, type: :model do
 # pending "add some examples to (or delete) #{__FILE__}"
#end

describe "User" do

  subject{ page }


  describe "profile page" do
    let(:user) {FactoryBot.create(:user)}
    let!(:m1) {FactoryBot.create(:micropost,user: user, content: "Foo")}
    let!(:m2) {FactoryBot.create(:micropost,user: user, content: "Bar")}

    before {visit user_path(user)}

    it{should have_selector('h1',text: user.name)}
    it{should have_selector('title',text: user.name)}

    describe "microposts" do
      it{ should have_content(m1.content)}
      it{ should have_content(m2.content)}
      it{ should have_content(user.microposts.count)}
    end
  end

  describe "index" do
    let(:user){FactoryBot.create(:user)}

    before do
      sign_in user
      visit users_path
    end

    it { should have_selector('title', text: 'All users') }
    it { should have_selector('h1',text: 'All users') }

    describe "pagination" do
    end

    describe "delete links" do

        it{should_not have_link('delete')}

        describe "as an admin user" do
            let(:admin) { FactoryBot.create(:admin) }
            before do
            sign_in admin
            visit users_path
        end
        it{ should have_link('delete', href: user_path(User.first))}
        it "should be able to delete user" do
            expect{click_link('delete')}.to change(User,:count).by(-1)
        end
        it{ should_not have_link('delete',href: user_path(admin))}
    end

    it "should list each user" do
      User.all.each do |user|
        page.should have_selector('li',text: user.name)
      end
    end
  end

  describe "signup" do

  before {visit signup_path}

  let(:submit) {"Create my account"}

  describe "with invalid information" do
    it "should not create a user"  do
      expect { click_button submit}.not_to change(User, :count)
    end
  end

  describe "remember token" do
    before {@user.save }
    its(:remember_token){should_not  be_blank}
    end
  end
    
  describe "with valid information" do
    before do
      fill_in "Name", with: "Example User"
      fill_in "Email", with: "user@example.com"
      fill_in "Address", with: "Example Location"
      fill_in "Phone", with: 5555555555
      fill_in "Password", with: "foo"
      fill_in "Confirm Password", with: "foo"
    end

    it {should respond_to(:password) }   
    it {should respond_to(:password_confirmation) }
    it {should respond_to(:remember_token) }
    it{should respond_to(:admin)}
    it {should respond_to(:authenticate)}
    it{should respond_to(:pasword_digest)}
    it{shoud respond_to(:microposts)}
    it{should respond_to(:feed) }
    it{should be_valid}
    it{should_not be_admin}

    describe "with admin attribute set to 'true'" do
      before{ @user.toggle!(:admin)}
      it{ shoud be_admin}
    end


    it "should create a user" do
      expect { click_button submit}.to change(User, :count).by(1)
    end
  end 
  
  describe "edit" do
    let(:user){FactoryBot.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end
    
    before {visit edit_user_path(user) }

    describe "page" do
      it{should have_selector('h1',text: "Udpate your profile")}
      it{ should have_selector('title',text: "Edit user")}
      it{ should have_link('change', href: "#")}
    end
    describe "with invalid information" do
      before{ click_button "Save changes"}

      it{should have_content('error')}
    end

    describe "with valid information" do
      let(:new_name) {"New Name"}
      let(:new_email){"new@example.com"}
      let(:new_address){"New Address"}
      let(:new_phone){"New Phone Contact"}
      before do
        fill_in "Name", with: new_name
        fill_in "Email", with:new_email
        fill_in "Address", with: new_address
        fill_in "Phone", with: new_phone
        fill_in "Password", with: user.password
        fill_in "Confirm  Password", with: user.password
        click_button "Save changes"
      end

      it{ should have_selector('title',text: new_name)}
      it{ should have_selector('div.alert.alert-success')}
      it{should have_link('Sign out', href: signout_path)}
      specify{user.reload.name.should ==new_name}
      specify{user.reload.email.should==new_email}
      specify{user.reload.phone.should==new_phone}
      specify{user.reload.address.should==new_address}
    end
  end

  describe "micropost asscociations" do

    before{ @user.save } 
    let!(:older_micropost) do
      FactoryBot.create(:micropost, user: @user, created_at: 1.day.ago)
    end

    let!(:newer_micropost) do
      FactoryBot.create(:micropost, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right microposts in the right order" do
      @user.microposts.should == [newer_micropost, older_micropost]
    end

    it "should destroy associated microposts" do
      microposts =@user.microposts
      @user.destroy
      microposts.each do |micropost|
        Micropost.find_by_id(micropost.id).should be_nil
      end
    end
    describe "status" do
      let(:unfollowed_post) do
        FactoryBot.create(:micropost, user: FactoryBot.create(:user))
      end
      its(:feed){ should include(newer_micropost) }
      its(:feed){should include(older_micropost) }
      its(:feed) {should_not include(unfollowed_post)}
    end
  end
end

