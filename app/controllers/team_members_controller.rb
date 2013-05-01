class TeamMembersController < ApplicationController
  include OnboardHelper

  # GET /leagues/:id/teams/new
  # GET /leagues/:id/teams/new.json
  def new
    @team = Team.find(params[:id])
    @team_member   = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @team }
    end
  end

  # POST /leagues/:id/teams
  # POST /leagues/:id/teams.json
  def create

    @team = Team.find(params[:team_id])
    @email = params[:user][:email].downcase.strip

    @member_account = Account.create_pending_or_find_existing(@email)

    @team_member = User.find_or_init(params[:user][:name], @member_account)

    @team_membership = TeamMember.new
    @team_membership.user = @team_member
    @team_membership.team = @team


    respond_to do |format|
      # Add to the team.
      if @team_membership.save
        # Setup the welcome message if the account is pending.
        url_for_player = team_path(@team)
        if (@member_account.pending?)
          description = "team_members/welcome"
          url_for_player = onboard_new_account_path_generator(@member_account, url_for_player, description, {:user_id => @team_member.id} )
        end

        # Send this email invite
        @member_account.send_invite!(:player_added_to_team, :user_id => @team_member.id, :team_id => @team.id, :url => url_for_player)

        format.html { redirect_to @team, notice: 'Player was successfully added. They were emailed a link to the team.' }
        format.json { render json: @team, status: :created, location: @team }
      else
        @team_member.errors.add :email, "That player is already on this team"

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
