class TeamsController < ApplicationController
  include OnboardHelper

  # GET /leagues/:id/teams
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
    @league = League.find(params[:id])
    @team   = Team.new
    @team.league = @league

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

    respond_to do |format|
      if @team.save

        # Manager needs to be sent the email to come manage his team (and signup!)
        # If he needs to sign-up, then he will be redirected there.
        url_for_manager = team_manager_assignment_path(@team.id)

        email = params[:team][:manager_email_address]
        url_for_manager = ActiveSupport::Base64.encode64(url_for_manager)
        token = token_for_onboard(email, url_for_manager)
        url_for_manager = signup_before_action_url(:token => token, :email => email, :description => "the #{@team.name} team page", :go_to => url_for_manager)

        UserMailer.team_created_email(email, @team, url_for_manager).deliver

        format.html { redirect_to @team, notice: 'Team was successfully created. Manager was emailed a link to the team.' }
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
