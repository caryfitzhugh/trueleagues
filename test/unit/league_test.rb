$:.unshift File.expand_path(File.dirname(__FILE__) + "/..")
require 'test_helper'

class LeagueTest < ActiveSupport::TestCase
  test "adding teams to a league" do
    team1 = Team.make!
    team2 = Team.make!

    league = League.make!

    league.add_team(team1)
    league.add_team(team2)

    league.save!
  end
end
