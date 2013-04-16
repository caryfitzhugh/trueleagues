class Location < ActiveRecord::Base
  attr_accessible :name, :notes

  has_many :games

end
