class ReadingContentsController < ApplicationController
  before_action :set_reading_content, only: [:show, :edit, :update, :destroy]

  # GET /reading_contents
  # GET /reading_contents.json
  def index
    @reading_contents = ReadingContent.all
  end

  # GET /reading_contents/1
  # GET /reading_contents/1.json
  def show
  end

  # GET /reading_contents/new
  def new
    @reading_content = ReadingContent.new
  end

  # GET /reading_contents/1/edit
  def edit
  end

  # POST /reading_contents
  # POST /reading_contents.json
  def create
    @reading_content = ReadingContent.new(reading_content_params)

    respond_to do |format|
      if @reading_content.save
        format.html { redirect_to @reading_content, notice: 'Reading content was successfully created.' }
        format.json { render :show, status: :created, location: @reading_content }
      else
        format.html { render :new }
        format.json { render json: @reading_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reading_contents/1
  # PATCH/PUT /reading_contents/1.json
  def update
    respond_to do |format|
      if @reading_content.update(reading_content_params)
        format.html { redirect_to @reading_content, notice: 'Reading content was successfully updated.' }
        format.json { render :show, status: :ok, location: @reading_content }
      else
        format.html { render :edit }
        format.json { render json: @reading_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reading_contents/1
  # DELETE /reading_contents/1.json
  def destroy
    @reading_content.destroy
    respond_to do |format|
      format.html { redirect_to reading_contents_url, notice: 'Reading content was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reading_content
      @reading_content = ReadingContent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reading_content_params
      params[:reading_content]
    end
end
