class TeamMembersController < ApplicationController
  include OnboardHelper

  # GET /team_member/:id
  # GET /leagues/:id/teams.json
  def index
    @league  = League.find(params[:id])
    redirect_to league_path(@league)
  end

  # GET /leagues/:id/teams/1
  # GET /leagues/:id/teams/1.json
  def show
    @team   = Team.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @league }
    end
  end

  # GET /leagues/:id/teams/new
  # GET /leagues/:id/teams/new.json
  def new
    @team = Team.find(params[:id])
    @team_member   = TeamMember.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @team }
    end
  end

  # GET /leagues/:id/teams/1/edit
  def edit
    @team   = Team.find(params[:id])
  end

  def manager
    @team   = Team.find(params[:id])
    if @team.manager.nil?
      @team.manager = current_user
    end
    redirect_to team_path(@team)
  end
  # POST /leagues/:id/teams
  # POST /leagues/:id/teams.json
  def create
    @league = League.find(params[:id])
    @team   = Team.new(params[:team])
    @team.league = @league

    @user = User.create_pending_or_find_existing(email)
    @team.players << @user
    @team.players.uniq!

    respond_to do |format|
      if @team.save

        url_for_player = team_path(@team)
        if (@user.pending?)
          description = "team_members/welcome"
          url_for_player = onboard_new_user_path_generator(@user, url_for_player, description)
        end

        UserMailer.added_to_team_email(@user.email, @team, url_for_player).deliver

        format.html { redirect_to @team, notice: 'Player was successfully added. They were emailed a link to the team.' }
        format.json { render json: @team, status: :created, location: @team }
      else
        format.html { render action: "new" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /leagues/:id/teams/1
  # PUT /leagues/:id/teams/1.json
  def update
    @league = League.find(params[:league_id])
    @team   = Team.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leagues/:id/teams/1
  # DELETE /leagues/:id/teams/1.json
  def destroy
    @team   = Team.find(params[:id])
    @team.destroy

    respond_to do |format|
      format.html { redirect_to leagues_url }
      format.json { head :no_content }
    end
  end
end
