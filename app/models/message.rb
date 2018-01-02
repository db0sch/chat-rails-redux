class Message < ApplicationRecord
  belongs_to :user
  belongs_to :channel
  validates :content, presence: true

  after_create :broadcast_message

  def broadcast_message
    message = {
      id: id,
      author: user.nickname,
      content: content,
      create_at: created_at,
      name: channel.name
    }
    ActionCable.server.broadcast("channel_#{channel.name}", {
      message: message.to_json
    })
  end
end
