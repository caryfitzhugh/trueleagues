class Game < ActiveRecord::Base
  attr_accessible :start_time, :notes, :duration
  belongs_to :location
  belongs_to :league

  belongs_to :home, :class_name => Team
  belongs_to :away, :class_name => Team
end
