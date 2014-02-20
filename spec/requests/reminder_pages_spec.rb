require 'spec_helper'

describe "ReminderPages" do

  subject{ page }

  let(:user){ FactoryGirl.create(:user) }
  before{ sign_in user }

  describe "reminder creation" do
    before{ visit root_path }

    describe "with invalid information" do

      it "should not create a reminder" do
        expect{ click_button "Create" }.not_to change(Reminder, :count)
      end

      describe "error messages" do
        before{ click_button "Create" }
        it { should have_content("error") }
      end
    end

    describe "with valid information" do
      before do
        fill_in "reminder_content", with: "Lorem ipsum"
        fill_in "reminder[time]", with: "02/20/2014 6:09 PM"
      end

      it "should create a reminder" do
        expect{ click_button "Create" }.to change(Reminder, :count).by(1)
      end
    end
  end

  describe "delete a reminder" do
    before do
        fill_in "reminder_content", with: "Lorem ipsum"
        fill_in "reminder[time]", with: "02/20/2014 6:09 PM"
        click_button "Create"
    end

    it "should delete the reminder" do
      expect{ click_link "delete" }.to change(Reminder, :count).by(-1)
    end
  end
end
