class CreateGamesOfficials < ActiveRecord::Migration
  def change
    create_table :games_officials do |t|
      t.integer :user_id
      t.integer :game_id

      t.timestamps
    end
  end
end
