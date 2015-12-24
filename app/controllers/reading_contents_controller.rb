class ReadingContentsController < ApplicationController
	# before_action :set_reading_content, only: [:show, :edit, :update, :destroy]

	# GET /reading_contents
	# GET /reading_contents.json
	def index
		@reading_contents = ReadingContent.find_by_sql "SELECT * FROM reading_contents ORDER BY created_at DESC LIMIT 10"



	end

end
