require 'spec_helper'

describe "Static pages" do

  describe "Home page" do
    it "should have the content 'Sample App'" do
        visit '/static_pages/home'
        page.should have content('Sample App')
    end
  end

  describe "Help page" do
    it "should have the content 'Help'" do
        visit '/static_pages/help'
        page.should have content('Help')
    end
  end

  describe "About page" do
    it "should have the h1 'About Us'" do
      visit '/static_pages/about'
      page.should have_selector('h1',:text=>'About Us')
    end

    it "should have the title 'About Us" do
      visit '/static_pages/about'
      page.should have_selector('title',:text=>"Job recruitment site | About Us")
    end
  end

end