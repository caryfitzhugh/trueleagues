class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string  :name
      t.integer :manager_id
      t.integer :league_id
      t.timestamps
    end
  end
end
