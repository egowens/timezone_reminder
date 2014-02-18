require 'spec_helper'

describe 'user_pages' do

  subject{ page }

  describe 'signup path' do
    before{ visit signup_path }

    it { should have_content('Sign Up!') }

    let(:submit) { "Create my account" }

    describe 'with invalid information' do
      it "should not create a new user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "should have errors" do
        before { click_button submit }

        it { should have_content('Sign Up') }
        it { should have_content('error') }
      end
    end

    describe 'with valid information' do
      before do
        fill_in "Name",       with: "Example User"
        fill_in "Email",      with: "user@example.com"
        fill_in "Password",   with: "foobar"
        fill_in "Confirm",    with: "foobar"
      end

      it "should create a new user" do
        expect{ click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before{ click_button submit }

        it { should have_content("Welcome") }
        end
    end
  end

  describe 'user show page' do
    let(:user) { FactoryGirl.create(:user) }
    before do
      user.save
      visit signin_path
      fill_in "Email",    with: user.email
      fill_in "Password", with: user.password
      click_button "Sign in"
      visit user_path(user)
    end

    it{ should have_content(user.name) }
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before{ visit edit_user_path(user) }

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

      it "should delete user" do
        expect do
          click_link "Remove account"
        end.to change(User, :count).by(-1)
      end

    describe "with invalid information" do
      before{ click_button "Save changes" }

      it { should have_content("error") }
    end

    describe "with valid information" do
      let(:new_name) { "New_name" }
      before do
        fill_in "Name",     with: new_name
        fill_in "Email",    with: user.email
        fill_in "Password", with: user.password
        fill_in "Confirm",  with: user.password
        click_button "Save changes"
      end

      specify { expect(user.reload.name). to eq new_name }
    end
  end
end
