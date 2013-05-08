module MessageBoardHelper
  def display_message_board(message_board)
    render "shared/message_board", :locals => { :message_board => message_board }
  end
end
