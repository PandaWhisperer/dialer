class CallsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    @call = Call.find(params[:id])

    response = Twilio::TwiML::VoiceResponse.new do |response|
      response.say "You are being connected. Please hold on...", voice: "alice"
      response.dial(number: @call.to_user.phone)
    end

    render xml: response
  end
end
