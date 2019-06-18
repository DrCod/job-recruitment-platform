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