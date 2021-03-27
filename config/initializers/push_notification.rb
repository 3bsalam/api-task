# frozen_string_literal: true

require 'pusher/push_notifications'

Pusher::PushNotifications.configure do |config|
  config.instance_id = ENV['PUSHER_INSTANCE_ID']
  config.secret_key = ENV['PUSHER_SECRET_KEY']
end
