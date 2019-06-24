require 'spec_helper'

describe "Static pages" do

  subject{page}


  

  describe "signup page" do
    before { visit signup_path }

    it{ should have_selector('h1',text: 'Sign up') }
    it{ should have_selector('title',text: 'Sign up')}
  end

  describe "Profile page" do
    let(:user) { FactoryBot.create(:user) }
    before {visit user_path(user) }
    it { should have_selector('h1', text: user.name) }
    it{ should have_selector('title', text: user.name) }
  end
  
  describe "Home page" do
    before{visit root_path}
    it{should have_selector('h1',text: 'Find job')} 
    it{should have_selector('title',text: full_title(''))}
    it{should_not have_selector 'title',text: '  |Home'}


    describe "for signed_in users" do
      let(:user) {FactoryBot.create(:user)}
      before do
        FactoryBot.create(:micropost,user: user.content: "Lorem ipsum")
        FactoryBot.create(:micropost,user:user,content: "Dolor sit amiet")
        signed_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}",text: item.content)
        end
      end
      describe "follower/following counts" do
        let(:other_user){ FactoryBot.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end

        it{should have_link("0 following", href: following_user_path(user))}
        it{ should have_link("1 follower",href: followwers_user_path(user))}
      end
    end

    it "should render the user's feed " do
      user.feed.each do |item|
        page.should have_selector("li##{item.id}",text: item.content)
      end
    end
    
  end

  describe "Help page" do
    before{visit help_path}
    it{should have_selector('h1',text: 'Help Me')}
    it{should have_selector('title',text: full_title('Help'))}
  end

  describe "About page" do
      before{visit about_path}
      it { should have_selector('h1',text: 'About Us')}
      it{should have_selector('title',text: full_title('About Us'))}
  end

  describe "Contact page" do
    before { visit contact_path }
    it { should have_selector('h1', text: 'Contact') }
    it { should have_selector('title', text: full_title('Contact')) }
  end



end