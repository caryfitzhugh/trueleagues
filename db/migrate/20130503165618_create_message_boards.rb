class CreateMessageBoards < ActiveRecord::Migration
  def change
    create_table :message_boards do |t|
      t.timestamps
    end

    create_table :message_board_messages do |t|
      t.integer :message_board_id
      t.integer :user_id
      t.text    :message
      t.timestamps
    end

    add_column :leagues, :message_board_id, :integer
    add_column :teams, :message_board_id, :integer
  end
end
