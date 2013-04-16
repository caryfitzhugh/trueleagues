$:.unshift File.expand_path(File.dirname(__FILE__) + "/..")
require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test "assign teams to games" do
    league = League.make!(:with_teams)

    # create game
    game = Game.new
    game.home = league.teams.first
    game.away = league.teams.second
    game.start_time= Time.now
    game.duration  = 1
    game.notes = "This is just a game"
    game.league = league
    game.location = Location.make!
    game.save!

  end
end
