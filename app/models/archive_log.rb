# frozen_string_literal: true

class ArchiveLog < ApplicationRecord
  enum operation: %i[archived unarchived]
  validates :operator, presence: true
  validates :operand, presence: true
  validates :operation, presence: true

  after_save :send_notification, :send_email
  def send_notification
    operatorobj = User.find_by(id: operator)
    operandobj = User.find_by(id: operand)
    PushNotificationService.notify_all_users(operatorobj, operandobj, operation.to_s)
  end

  def send_email
    operatorobj = User.find_by(id: operator)
    operandobj = User.find_by(id: operand)
    MailingService.email_all({
                               operator: operatorobj,
                               operand: operandobj,
                               operation: operation.to_s
                             })
  end
end
