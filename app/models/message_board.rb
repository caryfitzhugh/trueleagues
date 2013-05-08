class MessageBoard < ActiveRecord::Base
  has_many :messages, :class_name => "MessageBoardMessage"
end
