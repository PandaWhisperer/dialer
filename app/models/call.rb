class Call < ApplicationRecord
  belongs_to :from_user, class_name: 'User'
  belongs_to :to_user, class_name: 'User'

  after_create :connect_call

  private

  def connect_call
    call_url = Rails.application.routes.url_helpers.call_url(self,
      host: ActionMailer::Base.default_url_options[:host]
    )
    puts "M: Action Mailer settings: #{ActionMailer::Base.default_url_options}"
    puts "M: Call URL: #{call_url}"

    twilio_client.api.account.calls.create(
      from: '+14807197876', to: from_user.phone, url: call_url, method: 'GET'
    )
  end

  def twilio_client
    @twilio_client ||= Twilio::REST::Client.new
  end
end
