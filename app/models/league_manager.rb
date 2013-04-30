class  LeagueManager < ActiveRecord::Base
  belongs_to :league
  belongs_to :account
  validates_presence_of :league
  validates_presence_of :account
  validates :league_id, :uniqueness => {:scope => :account_id}
end
