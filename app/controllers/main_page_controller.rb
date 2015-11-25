#require "net/https"
require 'open-uri'
require 'nokogiri'
require 'mechanize'
require 'sanitize'
require 'rest-client'
require 'json'
require 'rufus-scheduler'
require 'gon'
class MainPageController < ApplicationController
  #index method
  #GET root
  #main page
  def index  
    killCurrentJob
  end
  
  #POST /resume
  #resumes text from scheduler
  def resume
    Rufus::Scheduler.singleton.job(session[:job_id]).resume
   respond_to do|format|
     format.html {redirect_to root_path}
     format.js
   end

  end 
  #POST /pause
  #pauses text from scheduler
  def pause
   Rufus::Scheduler.singleton.job(session[:job_id]).pause
   respond_to do|format|
     format.html {redirect_to root_path}
     format.js
   end
  end

  
  #POST /getUrl
  def getUrl
    #kill current rufus job if any
    killCurrentJob
   
    #getting params from form
    @url = params[:url]
    speed_page = params[:speed]
    color = params[:color]
    @toki = params[:token]
   
    #some initializing
    agent = Mechanize.new
    page = agent.get(@url)
    title = page.title
    doc = Nokogiri::HTML(page.body)
   
    #is color randomized or not?
    color ? @color_random = true : @color_random = false
   
     #what is speed of txt?    
    @speed = speed_page[0..2].to_i
    @speed = (60.0/@speed).to_s+'s'

    #if url is from medium
    if @url.include? "//medium."
      @data = doc.css("div.section-inner.layoutSingleColumn")  
    # process all other pages 
    else
     @data = doc.css('p,h1,h2,h3,h4,h5,h6');
    end
    
    #a little sanitation for clearing up text
    @data =  Sanitize.clean(@data)
   
    #array of words for scheduler
    @words_perma = @data.split(/\s/).delete_if(&:blank?)
    
    # if user is logged in, we save all relevant data to database
    if current_user
      @content = ReadingContent.create(user_id: current_user.id, title: title, content: @data,url: @url)   
   
    end
     
     #saving job id to session, so it can be accesed
     #and paused and resumed
     session[:job_id] = sender
     
     respond_to do |format|
       format.html {redirect_to root_path}
       format.js {}
     end
 end

  #method that kill current job so new job can take its place
  protected
  def killCurrentJob
      if session[:job_id] && Rufus::Scheduler.singleton.job(session[:job_id]) != nil
        Rufus::Scheduler.singleton.job(session[:job_id]).unschedule
        Rufus::Scheduler.singleton.job(session[:job_id]).kill
    end
  end 


  #method that runs scheduler and returns job_id
  protected
  def sender
      job = Rufus::Scheduler.singleton.every @speed  do
        if !@words_perma.empty?
          sendJSON(@color_random, @words_perma.shift, "http://localhost:4567", @toki)    
        end
      end 
      job
 end
  
  #method that sends json to sinatra app for coloring
  protected
  def sendJSON(color_random, word, color_app_adress,channel)
  # iterate through words and send them to coloring app
    response = RestClient.post color_app_adress + '/word', {:data=> {word: word, color_random: color_random, channel: channel}.to_json},{:content_type =>:json,:accept=> :json}
  end  
end
