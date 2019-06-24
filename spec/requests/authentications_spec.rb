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
        before{ sign_in user}

        it {should have_selector('title',text:  user.name)}
        it{ should have_link('Users',href: users_path)}
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
  describe "authorization" do

    def destroy
      @user =Relationship.find(params[:id]).followed
      current_user.unfollow!(@user)
      redirect_to @user
    end

    describe "as non-admin user" do
      let(:user) { FactoryBot.create(:user) }
      let(:non_admin) { FactoryBot.create(:user) }
      before { sign_in non_admin }

      describe "submitting a DELETE request to the Users#destroy action" do
        before{delete user_path(user)}
        specify{ response.should redirect_to(root_path)}
      end
    end
    
    describe "for non-signed-in users" do

      let(:user) {FactoryBot.create(:user)}

      describe "in the Users controller" do
        describe "followers" do
          before do
            sign_in other_user
            visit followers_user_path(other_user)
          end
          it{ should have_selector('title', text: full_title('Followers'))}
          it{should have_selector('h3'.text: 'Followers')}
          it{should have_link(user.name, href: user_path(user))}
        end
      end
      
      describe "in the Microposts controller" do
        describe "submitting to the create action" do
          before { post microposts_path }
          specify { response.should redirect_to(signin_path)}
        end
        describe "submitting to the destroy action" do
          before do
            micropost = FactoryBot.create(:micropost)
            delete micropost_path(micropost)
          end
          specify{ response.should redirect_to(signin_path)}
        end
      end
    end


      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Name", with: user.name
          fill_in "Email", with: user.email
          fill_in "Address", with: user.address
          fill_in "Phone", with: user.phone
          fill_in "Password", with: user.password
          fill_in "Confirm Password", with:user.password_confirm
          click_button "Sign in"
        end


        describe "after signing in" do
          it "should render the desired proctected page" do
            page.should  have_selector('title',text: 'Edit user')
          end
        end
      end

      describe "in the Users controller" do
        describe "visiting the edit page" do
          before{ visit edit_user_path(user)}
          it {should have_selector('title',text: 'Sign in')}
        end

        describe "submiting the update action" do
          before{ put user_path(user)}
          specify{response.should redirect_to(signin_path)}
        end


        describe "visiting the user index" do
          before {visit users_path }
          it{ should have_selector('title',text: 'Sign in')}
        end
      end
    end

    describe "as wrong user" do
      let(:user) {FactoryBot.create(:user) }
      let(:wrong_user) {FactoryBot.create(:user, email: "wrong@example.com")}

      before{sign_in user}

      describe "visiting Users#edit page" do
         before{ visit edit_user_path(wrong_user)}
         it{should have_selector('title',text: full_title('Edit user'))}
      end

      describe "submitting a PUT request to Users#update action" do
         before { put user_path(wrong_user)}
         specify{ response.should redirect_to(root_path)}
       end

    end
  end
end
