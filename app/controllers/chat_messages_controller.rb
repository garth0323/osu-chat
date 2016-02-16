class ChatMessagesController < ApplicationController
  respond_to :html, :js

  def index
    @chat_message = ChatMessage.new
  end

  def create
    @chat_messages = ChatMessage.create(chat_message_params)
    @chat_message = ChatMessage.new(chat_message_params)

    Pusher.trigger('chat', 'new_message', {
      name: @chat_message.name,
      message: @chat_message.message
    }, {
      socket_id: params[:socket_id]
    })
  end

  private

  def chat_message_params
    params.require(:chat_message).permit(:name, :message)
  end
end