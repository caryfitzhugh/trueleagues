class LeagueLocationsController < ApplicationController
  include OnboardHelper

  def index
    @league = League.find(params[:league_id])
    @location = Location.new
    @locations = Location.all
    @locations = @locations - @league.locations
  end

  def create
    @league = League.find(params[:league_id])
    @location = Location.find(params[:league_location][:location_id])
    begin
      @league.locations.push(@location)
      redirect_to league_locations_path(@league), :notice => "Added #{@location.name}"
    rescue ActiveRecord::RecordInvalid => e
      redirect_to league_locations_path(@league), :notice => "Error adding #{@location.name}"
    end
  end

  def destroy
    @league = League.find(params[:league_id])
    @location = Location.find(params[:location_id])
    begin
      @league.locations.delete(@location)
      redirect_to league_locations_path(@league), :notice => "Removed #{@location.name}"
    rescue ActiveRecord::RecordInvalid => e
      redirect_to league_locations_path(@league), :notice => "Error removing #{@location.name}"
    end
  end
end
