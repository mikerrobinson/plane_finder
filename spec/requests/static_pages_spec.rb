require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do

    before { visit root_path }
  
    it { should have_selector('h1', :text => 'Plane Renter') }
    it { should have_selector('title', :text => "Plane Renter | Home") }
    
  end
  
  describe "Help page" do

    before { visit help_path }

    it { should have_selector('h1', :text => 'Help') }
    it { should have_selector('title', :text => "Plane Renter | Help") }

  end
  
  describe "About page" do

    before { visit about_path }    
    
    it { should have_selector('h1', :text => 'About Us') }
    it { should have_selector('title', :text => "Plane Renter | About") }

  end
  
  describe "Contact page" do

    before { visit contact_path }
    
    it { should have_selector('h1', :text => 'Contact') }
    it { should have_selector('title', :text => "Plane Renter | Contact") }

  end
    
end