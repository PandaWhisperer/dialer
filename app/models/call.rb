class Call < ApplicationRecord
  belongs_to :from_user, class_name: 'User'
  belongs_to :to_user, class_name: 'User'

  before_create :extract_phone_numbers
  after_create :connect_call

  def connect_call
    # Compute full URL for call script
    call_url = Rails.application.routes.url_helpers.call_url(self,
      host: ActionMailer::Base.default_url_options[:host]
    )

    # Create an outoing phone call to the recruiter's number
    # Once connected, Twilio will access `call_url` to retrieve the call script
    twilio_client.api.account.calls.create(
      from: outgoing_phone_number, to: from_number, url: call_url, method: 'GET'
    )
  end

  private

  def extract_phone_numbers
    self.from_number = format_number(from_user.phone_number)
    self.to_number   = format_number(to_user.phone_number)
  end

  def format_number(str)
    # Parse and format phone number into Twilio-compatible format
    Phoner::Phone.parse(str).to_s
  end

  def twilio_client
    # Creates a new Twilio API client (configured in config/initializers/twilio.rb)
    @twilio_client ||= Twilio::REST::Client.new
  end

  def outgoing_phone_number
    # Determines which phone number to use for making outgoing calls
    ENV['TWILIO_PHONE_NUMBER']
  end
end
