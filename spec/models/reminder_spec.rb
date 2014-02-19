require 'spec_helper'

describe Reminder do

  let(:user) { FactoryGirl.create(:user) }
  before{ @reminder =user.reminders.build(content: "Lorem ipsum",
                             time: Time.now, user_id: user.id) }

  subject { @reminder }

  it { should respond_to(:content) }
  it { should respond_to(:time) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @reminder.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before{ @reminder.content = nil }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before{ @reminder.content = "a" * 141 }
    it { should_not be_valid }
  end

  describe "with blank time" do
    before{ @reminder.time = nil }
    it { should_not be_valid }
  end
end
