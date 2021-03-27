# frozen_string_literal: true

class LogMailer < ApplicationMailer
  def new_log
    @opts = params[:operation]

    mail(to: 'mostafa.abdelsalam96@gmail.com', subject: 'New operation happened')
  end
end
