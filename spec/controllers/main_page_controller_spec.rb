require 'rails_helper'

RSpec.describe MainPageController, type: :controller do
   
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

   end
   # cannot test anything with Rufus:Scehduler becaue
   # i must research more how to test classes with singleton instances
   '''
   describe "POST #resume" do
     it "responds succesfully with an http 200 status code" do
     s = Rufus::Scheduler.singleton
     session[:job_id] = "xd21s"
     post :resume
     expect(response).to be_success
     expect(response).to have_http_status(200)
     end
   end'''
   
end
