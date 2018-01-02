Message.destroy_all
Channel.destroy_all
User.destroy_all

require 'faker'

channels = %w(paris react general)

channels.each do |channel|
  Channel.create(name: channel)
end


User.create(email: "test@test.com", password: "password", nickname: "test")
User.create(email: "boby@test.com", password: "password", nickname: "bobby")

Channel.all.each do |channel|
  10.times do
    Message.create(user: User.all.sample, channel: channel, content: Faker::Hacker.say_something_smart )
  end
end
