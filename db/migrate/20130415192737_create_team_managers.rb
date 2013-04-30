class CreateTeamManagers < ActiveRecord::Migration
  def change
    create_table :team_managers do |t|
      t.integer :account_id
      t.integer :team_id

      t.timestamps
    end
  end
end
