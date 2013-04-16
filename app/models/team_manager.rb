class TeamManager < ActiveRecord::Base
  attr_accessible :title

  belongs_to :team
  belongs_to :user
end
