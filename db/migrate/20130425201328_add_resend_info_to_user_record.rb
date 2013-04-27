class AddResendInfoToUserRecord < ActiveRecord::Migration
  def change
    add_column(:users, :invite_email_data, :text, :default => nil)
  end
end
