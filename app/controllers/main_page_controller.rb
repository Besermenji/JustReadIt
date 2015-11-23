#require "net/https"
require 'open-uri'
require 'nokogiri'
require 'mechanize'
require 'sanitize'
class MainPageController < ApplicationController
 # require 'open-uri'
 # require 'nokogiri' 

  def index
  end
  
  def getUrl
    @url = params[:url]
    agent = Mechanize.new
    page = agent.get(@url)
    title = page.title
   # puts title
    doc =  Nokogiri::HTML(page.body) 
   # puts @data
    @data = doc.xpath("//p")
    @data =  Sanitize.clean(@data)
   # puts @data
    respond_to do |format|
      format.html {redirect_to root_path}
      format.js {}
    end 	
  end


end
