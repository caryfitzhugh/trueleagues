class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  # attr_accessible :title, :body
  has_many :teams, :through => :team_members
  has_many :managed_teams, :class_name => Team, :foreign_key => :manager_id

  serialize :invite_email_data

  def resend_invite!
    UserMailer.send("#{self.invite_email_data[:template]}_email", self.invite_email_data).deliver
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
    user = User.where(:email => email).first

    if (user)
      user
    else
      user = User.new
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
