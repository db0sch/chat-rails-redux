class Api::V1::MessagesController < ApplicationController
  before_action :set_channel

  def index
    @messages = Message.select(['id', 'created_at', 'content'])
                       .joins(:channel).select('name')
                       .where(channel: @channel)
                       .joins(:user).select(['nickname as author']).order(created_at: :asc)
    render json: @messages
  end

  def create
    message = Message.new(message_params)
    message.channel = @channel
    message.user = current_user
    message.save
    @message = {
      id: message.id,
      author: message.user.nickname,
      content: message.content,
      create_at: message.created_at,
      name: message.channel.name
    }
    render json: @message
  end

  private

  def set_channel
    @channel = Channel.find_by_name(params[:channel_id])
  end

  def message_params
    params.require(:message).permit(:content)

  end
end
