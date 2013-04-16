$:.unshift File.expand_path(File.dirname(__FILE__) + "/..")
require 'test_helper'

class TeamMemberTest < ActiveSupport::TestCase

  test "you can be on a team" do
    user = User.make!
    team = Team.make!

    team.players << user
    team.save!

    assert_equal [user], team.players

    team.remove_player(user)
    team.save!

    assert_equal [], team.players
  end

end
