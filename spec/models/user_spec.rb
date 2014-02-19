require 'spec_helper'

describe User do
  before do
    @user = User.new(name:"Test_user", email:"user@example.com", password: "foobar", password_confirmation: "foobar")
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:reminders) }

  it { should be_valid }

  describe "when name is not valid" do
    before { @user.name = '' }
    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { @user.password = '', @user.password_confirmation = '' }
    it { should_not be_valid }
  end

  describe "when passwords mismatch" do
    before { @user.password = 'foobar', @user.password_confirmation = 'mismatch' }
    it { should_not be_valid }
  end

  describe "remember token" do
    before{ @user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "reminder associations" do

    before { @user.save }
    let!(:later_reminder) do
      FactoryGirl.create(:reminder, content: "later", user: @user, time: Time.now+10.days)
    end
    let!(:sooner_reminder) do
      FactoryGirl.create(:reminder, content: "sooner", user: @user, time: Time.now+10.hours)
    end

    it "should have the right reminders in the right order" do
      expect(@user.reminders.to_a).to eq [sooner_reminder, later_reminder]
    end

    it "should destroy associated reminders" do
      reminders = @user.reminders.to_a
      @user.destroy
      expect(reminders).not_to be_empty
      reminders.each do |reminder|
        expect(Reminder.where(id: reminder.id)).to be_empty
      end
    end
  end
end
