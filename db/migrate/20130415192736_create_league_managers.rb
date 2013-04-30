class CreateLeagueManagers < ActiveRecord::Migration
  def change
    create_table :league_managers do |t|
      t.integer :account_id
      t.integer :league_id

      t.timestamps
    end
  end
end
