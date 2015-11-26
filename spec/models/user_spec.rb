require 'rails_helper'
ActiveRecord::Migration.maintain_test_schema!
RSpec.describe User, type: :model do
  it "create user with username" do
  user = User.create(username:"test_user", email:"test@user.com" ,password:"iamironman123",password_confirmation:"iamironman123")
  expect(user.username).to eq("test_user")
  end
end
