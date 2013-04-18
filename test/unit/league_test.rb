$:.unshift File.expand_path(File.dirname(__FILE__) + "/..")
require 'test_helper'

class LeagueTest < ActiveSupport::TestCase
  test "create league with dates" do
    league = League.new
    league.name = "trest"
    league.start_date = "01/01/2014"
    league.end_date   = "01/02/2014"
    league.save!
  end

  test "adding teams to a league" do
    league = League.make!
    team1 = Team.make!(:league => league)
    team2 = Team.make!(:league => league)

    league.teams << (team1)
    league.teams << (team2)

    league.save!

    assert_equal 2, league.teams.length
  end
end
