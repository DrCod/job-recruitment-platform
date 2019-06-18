require 'spec_helper'

#RSpec.describe User, type: :model do
 # pending "add some examples to (or delete) #{__FILE__}"
#end

describe "User pages" do

  subject{ page }

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
      fill_in "Phone", with: "Example Phone"
      fill_in "Password", with: "foo"
      fill_in "Confirm Password", with: "foo"
    end

    it {should respond_to(:password) }   
    it {should respond_to(:password_confirmation) }
    it {should respond_to(:remember_token) }
    it{should respond_to(:admin)}
    it {should respond_to(:authenticate)}
    it{should respond_to(:pasword_digest)}
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
end

