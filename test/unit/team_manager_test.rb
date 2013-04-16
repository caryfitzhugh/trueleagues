$:.unshift File.expand_path(File.dirname(__FILE__) + "/..")
require 'test_helper'

class TeamManagerTest < ActiveSupport::TestCase
  test "teams can have multiple managers" do
    coach =  User.make!
    asst  =  User.make!

    team = Team.make!

    team.add_manager(coach, "coach")
    team.add_manager(asst, "asst coach")
    team.save!

    team.reload
    assert_equal 2, team.managers.count
  end
end
