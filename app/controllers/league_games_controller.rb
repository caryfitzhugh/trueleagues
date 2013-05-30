class LeagueGamesController < ApplicationController
  include OnboardHelper

  def index
    @league = League.find(params[:league_id])
    @games = @league.games
  end

  def new
    @league = League.find(params[:league_id])
  end

  def create

    @league = League.find(params[:league_id])
    @location = @league.locations.find(params[:game][:location])
    @home_team = @league.teams.find(params[:game][:home])
    @away_team = @league.teams.find(params[:game][:away])

    @game = Game.new
    @game.location = @location
    @game.home = @home_team
    @game.away = @away_team
    @game.start_time = params[:game][:start_time]
    @game.league = @league

    respond_to do |format|
      if @game.save
        format.html do
          path = league_games_path(:league_id => @league.id)
          redirect_to( path, notice: 'Game was successfully created.')
        end

        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { render action: "new" }
        format.json { render json: @game.errors, status: :unprocessable_entity }

      end
    end
  end

  def destroy
    @league = League.find(params[:league_id])
    game = @league.games.find(params[:id])
    game.destroy

    respond_to do |format|
      format.html { redirect_to league_games_url(:league_id => @league.id), notice: "Deleted game" }
      format.json { head :no_content }
    end
  end
end
