module MessageBoardHelper
  def display_message_board(target)
    render :partial => "shared/message_board", :locals => { :target => target}
  end
end
