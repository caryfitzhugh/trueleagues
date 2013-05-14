class LeagueLocations < ActiveRecord::Migration
  def change
    create_table :league_locations do |t|
      t.integer :league_id
      t.integer :location_id
      t.timestamps
    end
  end
end
