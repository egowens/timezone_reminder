require 'spec_helper'

describe "Authentication" do

  subject{ page }

  describe "signin page" do
    before { visit signin_path }

    it{ should have_content("Sign in") }

    describe "with invalid info" do
      before { click_button "Sign in" }

      it{ should have_content("Sign in") }
      it{ should have_selector("div.alert.alert-danger") }

      describe "after visiting another page" do
        before { visit root_path }

        it{ should_not have_selector('div.alert.alert-danger') }
      end
    end

    describe "with valid login" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",      with: user.email.upcase
        fill_in "Password",   with: user.password
        click_button "Sign in"
      end

      it{ should have_content(user.name) }
      it{ should_not have_content("Sign in") }
      it{ should have_link("Sign out",    href: signout_path) }
      it{ should_not have_link("Sign in", href: signin_path) }

      describe "Sign current user out" do
        before { click_link "Sign out" }

        it { should have_content("Sign in") }
        it { should have_content("Sign up now!") }
        it { should_not have_content("Sign out") }
        it { should_not have_content("Settings") }
      end
    end
  end
end
