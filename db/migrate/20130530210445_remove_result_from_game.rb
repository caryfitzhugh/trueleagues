class RemoveResultFromGame < ActiveRecord::Migration
  def up
    remove_column(:games, :result)
  end

  def down
    add_column(:games, :result, :string)
  end
end
