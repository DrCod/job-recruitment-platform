require 'spec_helper'

#RSpec.describe User, type: :model do
 # pending "add some examples to (or delete) #{__FILE__}"
#end

describe "User" do

  subject{ page }


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
    it {should respond_to(:authenticate)}
    it{should respond_to(:pasword_digest)}


    it "should create a user" do
      expect { click_button submit}.to change(User, :count).by(1)
    end
  end  
end

