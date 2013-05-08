class MessageBoardController < ApplicationController

  def index
    @target = (params[:target_type].constantize).find(params[:target_id])

    # TODO Validate access to that target by this user
  end

  def new
    @target = (params[:target_type].constantize).find(params[:target_id])
    @message = MessageBoardMessage.new
    @message.message_board = @target.message_board

  end

  def create
    @target = (params[:target_type].constantize).find(params[:target_id])
    @message = MessageBoardMessage.new
    @message.message_board = @target.message_board
    @message.message = params[:message_board_message][:message]
#    @message.user =
    @message.save

    respond_to do |format|
      if @message.save

        format.html { redirect_to @target, notice: 'Message was successfully posted.' }
        format.json { render json: @target, status: :created, location: @target }
      else
        format.html { render action: "new" }
        format.json { render json: @target.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

  end

end
