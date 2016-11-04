class ReadingContentsController < ApplicationController
  # before_action :set_reading_content, only: [:show, :edit, :update, :destroy]

  # GET /reading_contents
  # GET /reading_contents.json
  def index
    @reading_contents = ReadingContent.last(10)
  end

end
