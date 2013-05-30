class Game < ActiveRecord::Base
  attr_accessible :start_time, :notes
  belongs_to :location
  belongs_to :league

  belongs_to :home, :class_name => Team
  belongs_to :away, :class_name => Team

  validates_presence_of :home
  validates_presence_of :away
  validates_presence_of :start_time

  validate do
    errors.add(:base, "Can't have the same team as home and away") if self.home_id == self.away_id
  end
end
