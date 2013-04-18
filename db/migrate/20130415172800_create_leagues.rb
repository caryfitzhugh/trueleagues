class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.date      :start_date
      t.date      :end_date
      t.string    :name

      t.string    :scoring_system, :default => :default
      t.timestamps
    end
  end
end
