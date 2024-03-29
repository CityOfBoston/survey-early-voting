class LocationsController < ApplicationController
  http_basic_authenticate_with name: ENV["USERNAME"], password: ENV["PASSWORD"], except: [:index, :show, :yay]
  before_action :set_location, only: [:show, :edit, :update, :destroy, :yay]

  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all
    @has_posted = cookies[:posted] || false
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @has_posted = cookies[:posted] || false
  end

  def yay
    @vote = @location.votes.build

    respond_to do |format|
      if @vote.save
        cookies[:posted] = { :value => true, :expires => 1.year.from_now }
        format.html { redirect_to location_vote_path(@location, @vote), notice: 'Thank you for voting!' }
      else
        format.html { redirect_to root_path, error: 'There was an error saving your vote. Contact EVfeedback@boston.gov if it continues.' }
      end
    end
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:name, :lat, :lng, :description)
    end
end
