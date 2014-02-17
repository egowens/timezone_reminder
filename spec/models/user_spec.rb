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
end
