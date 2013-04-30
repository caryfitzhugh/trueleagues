class TeamManager < ActiveRecord::Base
  belongs_to :team
  belongs_to :account
  validates_presence_of :team
  validates_presence_of :account
  validates :team_id, :uniqueness => {:scope => :account_id}
end
