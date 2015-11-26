require 'rails_helper'

RSpec.describe ReadingContent, type: :model do
  it "create reading content" do
   user = User.create(username:"test_user", email:"test@user.com" ,
		     password:"iamironman123",password_confirmation:"iamironman123")

  reading_content = ReadingContent.create(user_id: user.id, title: "some title", content: "some txt",
                                          url: "http://some.webpage.com")

  expect(ReadingContent.where(user_id: user.id)).to be_present
  end
end
