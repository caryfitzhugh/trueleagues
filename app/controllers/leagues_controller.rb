class LeaguesController < ApplicationController
  include OnboardHelper

  # GET /leagues
  # GET /leagues.json
  def index
    @leagues = League.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @leagues }
    end
  end

  # GET /leagues/1
  # GET /leagues/1.json
  def show
    @league = League.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @league }
    end
  end

  # GET /leagues/new
  # GET /leagues/new.json
  def new
    @league = League.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @league }
    end
  end

  # GET /leagues/1/edit
  def edit
    @league = League.find(params[:id])
  end

  # POST /leagues
  # POST /leagues.json
  def create
    @league = League.new(params[:league])

    respond_to do |format|
      if @league.save

        format.html { redirect_to @league, notice: 'League was successfully created.' }
        format.json { render json: @league, status: :created, location: @league }
      else
        format.html { render action: "new" }
        format.json { render json: @league.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /leagues/1
  # PUT /leagues/1.json
  def update
    @league = League.find(params[:id])

    respond_to do |format|
      if @league.update_attributes(params[:league])
        format.html { redirect_to @league, notice: 'League was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @league.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leagues/1
  # DELETE /leagues/1.json
  def destroy
    @league = League.find(params[:id])
    @league.destroy

    respond_to do |format|
      format.html { redirect_to leagues_url }
      format.json { head :no_content }
    end
  end

  def schedule
    @league = League.find(params[:league_id])
  end

  def update_schedule

  end

  def locations
    @league = League.find(params[:league_id])
    @location = Location.new
    @locations = Location.all
    @locations = @locations - @league.locations

  end

  def add_location
    @league = League.find(params[:league_id])
    @location = Location.find(params[:league_location][:location_id])
    begin
      @league.locations.push(@location)
      redirect_to league_locations_path(@league, :notice => "Added #{@location.name}")
    rescue ActiveRecord::RecordInvalid => e
      redirect_to league_locations_path(@league, :notice => "Error adding #{@location.name}")
    end
  end

  def remove_location
    @league = League.find(params[:league_id])
    @location = Location.find(params[:location_id])
    begin
      @league.locations.delete(@location)
      redirect_to league_locations_path(@league, :notice => "Removed #{@location.name}")
    rescue ActiveRecord::RecordInvalid => e
      redirect_to league_locations_path(@league, :notice => "Error removing #{@location.name}")
    end

  end
end
