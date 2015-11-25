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
  def index  
    killCurrentJob
  end
 
  #resume method
  def resume
   #puts session[:job_id]
   # Rufus::Scheduler.singleton.job(session[:job_id])
    Rufus::Scheduler.singleton.job(session[:job_id]).resume
   respond_to do|format|
     format.html {redirect_to root_path}
     format.js
   end

  end 
  #pause method
  def pause
   Rufus::Scheduler.singleton.job(session[:job_id]).pause
   respond_to do|format|
     format.html {redirect_to root_path}
     format.js
   end
  end


 
  def getUrl
    #kill current rufus job if any
    killCurrentJob
    #getting params from form
    @url = params[:url]
    speed_page = params[:speed]
    color = params[:color]
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
    #  puts "substart page"
    else
     @data = doc.css('p');
    end
    
    
    @data =  Sanitize.clean(@data)
    @words_perma = @data.split(/\s/).delete_if(&:blank?)
    # if user is logged in, we save all relevant data to database
    if current_user
      @content = ReadingContent.create(user_id: current_user.id, title: title, content: @data,url: @url)   
   
    end
     #getting job_id for pausing
     session[:job_id] = sender
     puts @job_id
     respond_to do |format|
       format.html {redirect_to root_path}
       format.js {}
     end


     	
  end

  protected
  def killCurrentJob
      if session[:job_id]
      Rufus::Scheduler.singleton.job(session[:job_id]).unschedule
      Rufus::Scheduler.singleton.job(session[:job_id]).kill
      puts "killed him"
    end

  end 

  protected
  def sender
      job = Rufus::Scheduler.singleton.every @speed  do
       # Rails.logger.info "time flies, it's now #{Time.now}"
        if !@words_perma.empty?
          sendJSON(@color_random, @words_perma.shift, "http://localhost:4567")    
        end
      end 
      job
 end

 
 
  
  protected
  def sendJSON(color_random, word, color_app_adress)
  # iterate through words and send them to coloring app
    response = RestClient.post color_app_adress + '/word', {:data=> {word: word, color_random: color_random}.to_json},{:content_type =>:json,:accept=> :json}
  end  
end
