class Account < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :teams, :through => :team_managers
  has_many :team_managers

  has_many :leagues, :through => :league_managers
  has_many :league_managers

  has_many :users

  serialize :invite_email_data
  before_save { |account| account.email = account.email.downcase.strip }

  def resend_invite!
    AccountMailer.send("#{self.invite_email_data[:template]}_email", self.invite_email_data).deliver
  end

  def send_invite!(template, data={})
    self.invite_email_data = {:email => self.email, :template => template}.merge(data)
    save!
    resend_invite!
  end

  def self.find_for_authentication(conditions)
    super(conditions.merge(:pending => false))
  end

  def self.create_pending_or_find_existing(email)
    user = Account.where(:email => email).first

    if (user)
      user
    else
      user = Account.new
      user.pending = true
      user.email = email
      user.save!
      user
    end

  end

  def pending?
    !!self.pending
  end

  def password_required?
    if pending?
      false
    else
      super
    end
  end
end
