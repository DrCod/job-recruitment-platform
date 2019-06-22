require 'spec_helper'

#RSpec.describe User, type: :model do
 # pending "add some examples to (or delete) #{__FILE__}"
#end

describe "User pages" do

    before do
        @user = User.new(name: "Example",email: "user@example.com",address: "Example",phone: 5555555555,password: "foobvar",password_confirm: "foobvar")
    end

    subject{ @user}
  describe "index" do
    before do
      sign_in FactoryBot.create(:user)
      FactoryBot.create(:user, name: "Bob", email: "bob@example.com",address: "Example",phone: 5555555555,password: "foobvar",password_confirm: "foobvar")
      FactoryBot.create(:user, name: "Ben", email: "ben@example.com",address: "Example",phone: 5555555555,password: "foobvar",password_confirm: "foobvar")
      visit users_path
    end

    it { should have_selector('title', text: 'All users') }
    it { should have_selector('h1',text: 'All users') }

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
      
      
          
        describe "with valid information" do
          before do
            fill_in "Name", with: "Example User"
            fill_in "Email", with: "user@example.com"
            fill_in "Address", with: "Example Location"
            fill_in "Phone", with: 0000000000
            fill_in "Password", with: "foo"
            fill_in "Confirm Password", with: "foo"
          end

        end
    end

    it{ should respond_to(:name) }
    it{shold respond_to(:email)}
    it{shold respond_to(:address)}
    it{shold respond_to(:phone)}
    it{shold respond_to(:password)}
    it{shold respond_to(:password_confirm}
    it{should respond_to(:password_digest)}
    it{should respond_to(:authenticate)}


    it{ should be_valid }

    describe "with a password that's too short" do
        before{@user.password =@password_confirm="a"*5}
        it{ should be_invalid}
    end
  describe "remember token" do
    before {@user.save }
    its(:remember_token){should_not  be_blank}
    end
  end
    
    describe "when name is not present" do
        before {@user.name =" "}
        it { should_not be_valid}
    end

    describe "when email is not present" do
        before {@user.email =" "}
        it{ should_not be_valid}
    end
    describe "when address is not present" do
        before {@user.address =" "}
        it{ should_not be_valid}
    end
    describe "when phone is not present" do
        before {@user.phone =0000000000}
        it{ should_not be_valid}
    end
    describe "when password is not present" do
        before {@user.password =@user.password_confirm=" "}
        it{ should_not be_valid}
    end
    describe "when email is not present" do
        before {@user.password_confirm =" "}
        it{ should_not be_valid}
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

    describe "when password doesn't match confirmation" do
        before{ @user.password_confirm="mismatch"}
        it{ should_not be_valid}
    end

    describe "when password confirmation is nil" do
        before {@user.password_confirm =nil}
        it{ should_not be_valid}
    end

    describe "when name is too long" do
        before{ @user.name = "a"*51}
        it{should_not be_valid}
    end
    
    it "should create a user" do
        expect { click_button submit}.to change(User, :count).by(1)
      end

    describe "when email format is invalid" do
        it "should be invalid" do
            addresses =%w[user@foo.com user_at_foo.org 
        example.user@foo foo@bar+bar.com]
        addresses.each do |invalid_address|
            @user.email = invalid_address
            @user.should_not be_valid
        end
    end
    
    describe "when email format is valid" do
        it "should be valid" do
            addresses =%w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
            addresses.each do |valid_address|
                @user.email = valid_address
                @user.should be_valid
        end
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

    describe "when email address is already taken" do
        before do
            user_with_same_email =@user.dup
            user_with_same_email.save
        end
        it{ should_not be_valid}
    end

    describe "return value of authenticate method" do
        before {@user.save}
        let(:found_user){User.find_by_email(@user.email)}

        describe "with valid password" do
            it{should == found_user.authenticate(@user.password)}
        end

        describe "with invalid password" do
            let(:user_for_invalid_password){ found_user.authenticate("invalid")}

            it{should_not == user_for_invalid_password}
            specify{ user_for_invalid_password.should be_false}
        end
    end
end
