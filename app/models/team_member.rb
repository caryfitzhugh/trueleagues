class TeamMember < ActiveRecord::Base
  attr_accessible :team_id, :user_id
  belongs_to :team
  belongs_to :user
  validates_presence_of :team
  validates_presence_of :user
  validates_uniqueness_of :user_id, :scope => [:team_id]
end
