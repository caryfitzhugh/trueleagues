class User  < ActiveRecord::Base
  attr_accessor :email
  attr_accessible :email

  belongs_to :account
  validates_presence_of :account

  def self.find_or_init(name, account)
    name = name.downcase.strip

    @player = User.where(:name => name, :account_id => account.id).first

    if (@player.nil?)
      @player = User.new
      @player.name = name
      @player.account_id = account.id
    end

    @player
  end

  validates_uniqueness_of :name, :scope => [:account_id]

  before_save { |user| user.name = user.name.downcase.strip }
end
