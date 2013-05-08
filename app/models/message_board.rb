class MessageBoard < ActiveRecord::Base
  has_many :message_board_messages
end
