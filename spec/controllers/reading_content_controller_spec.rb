require 'rails_helper'

RSpec.describe ReadingContentsController, type: :controller do

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    
   it "renders the index template" do
      get :index
      expect(response).to render_template("index")
   end
   
    it "loads @reading_contents, reverses them and take first 10" do
      user = User.create(username:"test_user", email:"test@user.com" ,
		     password:"iamironman123",password_confirmation:"iamironman123")

      reading_content1 = ReadingContent.create(user_id: user.id, title: "some title", content: "some txt",
                                          url: "http://some.webpage.com")
      reading_content2 = ReadingContent.create(user_id: user.id, title: "some title", content: "some txt",
                                          url: "http://some.webpage.com")
      reading_content3 = ReadingContent.create(user_id: user.id, title: "some title", content: "some txt",
                                          url: "http://some.webpage.com")
      reading_content4 = ReadingContent.create(user_id: user.id, title: "some title", content: "some txt",
                                          url: "http://some.webpage.com")
      reading_content5 = ReadingContent.create(user_id: user.id, title: "some title", content: "some txt",
                                          url: "http://some.webpage.com")
      reading_content6 = ReadingContent.create(user_id: user.id, title: "some title", content: "some txt",
                                          url: "http://some.webpage.com")
      reading_content7 = ReadingContent.create(user_id: user.id, title: "some title", content: "some txt",
                                          url: "http://some.webpage.com")
      reading_content8 = ReadingContent.create(user_id: user.id, title: "some title", content: "some txt",
                                          url: "http://some.webpage.com")
      reading_content9 = ReadingContent.create(user_id: user.id, title: "some title", content: "some txt",
                                          url: "http://some.webpage.com")
      reading_content10 = ReadingContent.create(user_id: user.id, title: "some title", content: "some txt",
                                          url: "http://some.webpage.com")
      reading_content11 = ReadingContent.create(user_id: user.id, title: "some title", content: "some txt",
                                          url: "http://some.webpage.com")
 

      get :index

      expect(assigns(:reading_contents)).to match_array([reading_content11, reading_content10, reading_content9,
      reading_content8, reading_content7,  reading_content6,  reading_content5,  reading_content4, 
      reading_content3,  reading_content2   ])
    end
  end


end
