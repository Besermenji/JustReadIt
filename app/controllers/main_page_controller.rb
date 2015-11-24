#require "net/https"
require 'open-uri'
require 'nokogiri'
require 'mechanize'
require 'sanitize'
require 'rest-client'
require 'json'
require 'rufus-scheduler'
class MainPageController < ApplicationController
 # require 'open-uri'
 # require 'nokogiri' 

  def index
  end
  
  def getUrl
    @url = params[:url]
    #initializing variables for parsing page source
    agent = Mechanize.new
    page = agent.get(@url)
    title = page.title
    doc = Nokogiri::HTML(page.body)
    #is color randomized or not?
    color_random = true
    #what is speed of txt?
    
    speed = 300
    #if url is from medium
    if @url.include? "//medium."
     # puts "start page"
      @data = doc.css("div.section-inner.layoutSingleColumn")  
   # elsif @url.include? "//medium."
    #  puts "substart page"
    else
     @data = doc.css('p');
    end
    
    
    @data =  Sanitize.clean(@data)
    #puts @data
    #a little regexp for spliting data in words array
    words = @data.split(/\s/).delete_if(&:blank?)
    
    # if user is logged in, we save all relevant data to database
    if current_user
      @content = ReadingContent.create(user_id: current_user.id, title: title, content: @data,url: @url)   
   
    end
  
    # scheduler = Rufus::Scheduler.new
     while !words.empty?
      #calling method for sending json to coloring app
     # scheduler.in (60.0/speed).to_s + "s" do
      sendJSON(color_random, words.shift, "http://localhost:4567")
     # end
      sleep(60.0/speed)
    end  
     #scheduler.shutdown
     
     respond_to do |format|
       format.html {redirect_to root_path}
       format.js {}
     end


     	
  end

  private
  def sendJSON(color_random, word, color_app_adress)
  # iterate through words and send them to coloring app
    response = RestClient.post color_app_adress + '/word', {:data=> {word: word, color_random: color_random}.to_json},{:content_type =>:json,:accept=> :json}
  end  
end
