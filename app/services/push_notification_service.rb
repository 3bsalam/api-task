# frozen_string_literal: true

# class responsible of sending notifications to users when operation happens
require 'pusher/push_notifications'
class PushNotificationService
  def self.notify_all_users(operator, operand, operation)
    params = build_notification_params(operator, operand, operation)
    Pusher::PushNotifications.publish_to_interests(interests: ['Operations'], payload: params)
  end

  def self.build_notification_params(operator, operand, operation)
    {
      web: {
        notification: {
          title: 'New operation happened',
          body: "This is to notify that user #{operand.email} has been #{operation} by #{operator.email}",
          deep_link: 'https://www.pusher.com'
        }
      }
    }
  end
end
