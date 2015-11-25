class ReadingContentsController < ApplicationController
 # before_action :set_reading_content, only: [:show, :edit, :update, :destroy]

  # GET /reading_contents
  # GET /reading_contents.json
  def index
    @reading_contents = ReadingContent.all
    @reading_contents = @reading_contents.reverse
    @reading_contents = @reading_contents.take(10) unless @reading_contents.length < 10
      
  end

end
