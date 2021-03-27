# frozen_string_literal: true

class MailingService
  def self.email_all(opts)
    LogMailer.with(operation: opts).new_log.deliver_now
  end
end
