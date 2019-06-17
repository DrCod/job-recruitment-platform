require 'spec_helper'

RSpec.describe "Authentications", type: :request do
  describe "GET /authentications" do


    subject { page }
    describe "signin page" do
      before { visit signin_path }

      it { should have_selector('h1',text: 'Sign in') }
      it { should have_selector('title', text: 'Sign in') }
    end

    describe "signin" do
      before{visit signin_path}


      describe "with valid information" do
        let(:user){FactoryBot.create(:user)}
        before do
          fill_in "Email", with: user.email
          fill_in "Password" with: user.password
          click_button "Sign in"
        end
    

        describe "followed by signout" do
          before{ click_link "Sign out"}
          it{ should have_link('Sign in')}
        end

        it {should have_selector('title',text:  user.name)}
        it{ should have_link('Profile', href: user_path(user))}
        it{should have_link('a','Sign out',href: signout_path)}
        it{should_not have_link('Sign in',href: signin_path)}
      end


         

      describe "with invalid information" do
        before{click_button "Sign in"}

        it {should have_selector('title',text: 'Sign in')}
        it {should have_selector('div.alert.alert-error',text: 'Invalid')}
      end
    end
 
    it "works! (now write some real specs)" do
      get authentications_path
      expect(response).to have_http_status(200)
    end
  end
end

end
