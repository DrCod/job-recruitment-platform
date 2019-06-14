require 'spec_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

describe "User pages" do

  subject{ page }


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
      fill_in "Phone", with: "Example Phone"
      fill_in "Password", with: "foo"
      fill_in "Confirm Password", with: "foo"
    end

    it "should create a user" do
      expect { click_button submit}.to change(User, :count).by(1)
    end
  end  
end

