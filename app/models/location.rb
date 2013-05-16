class Location < ActiveRecord::Base
  attr_accessible :name, :notes
  before_save { |location| location.name = location.name.downcase.strip }

  has_many :games
  has_many :leagues
end
