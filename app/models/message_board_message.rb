class MessageBoardMessage < ActiveRecord::Base
  attr_accessible :message

  belongs_to :user
  belongs_to :message_board
end
