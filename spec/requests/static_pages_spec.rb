require 'spec_helper'

describe 'static pages' do

  describe 'home page' do

   it 'should have the h1 Timezone Reminder' do
     visit root_path
     expect(page).to have_content('Timezone Reminder')
   end
  end

  describe 'help page' do

    it 'should have the h1 Help' do
      visit help_path
      expect(page).to have_content('Help')
    end
  end

  describe 'About page' do

    it 'should have the h1 About' do
      visit about_path
      expect(page).to have_content('About')
    end
  end

  describe 'Signup page' do

    it 'should have the h1 Sign up' do
      visit signup_path
      expect(page).to have_content('Sign Up')
    end
  end
end
