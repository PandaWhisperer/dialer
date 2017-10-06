class CallsController < ApplicationController
  # Twilio doesn't send a CSRF token, so we have to disable checking it
  skip_before_action :verify_authenticity_token, only: :connect

  # POST /users/:id/call
  #
  # Called when user clicks on the "Call" button
  #
  def create
    @user = User.find(params[:id])
    @call = Call.create(from_user: current_user, to_user: @user)

    redirect_to users_path, notice: 'Call in progress. Please wait...'
  end

  # POST /calls/:id
  #
  # Called by Twilio to retrieve the script for an ongoing call
  #
  def connect
    @call = Call.find(params[:id])

    if params[:Digits]
      # If the `Digits` parameter is present, we've received a keypress
      # and should move forward with dialing the number.
      render xml: dial_number(@call.to_number)
    else
      # Otherwise, respond with a voice prompt asking for a keypress
      render xml: wait_for_keypress
    end
  end

  private

  def wait_for_keypress
    # TwiML response that gives a voice prompt and waits for a single digit to be entered
    # If no response has been received within 10 seconds, the call with terminate
    Twilio::TwiML::VoiceResponse.new do |response|
      response.gather(num_digits: 1, timeout: 10) do |gather|
        gather.say 'Please press any number to be connected.', voice: "alice"
      end
      response.say 'We did not receive any input. Goodbye.', voice: "alice"
    end
  end

  def dial_number(phone_number)
    # TwiML response that dials a given phone number and adds it to the call
    Twilio::TwiML::VoiceResponse.new do |response|
      response.say "You are being connected. Please hold on...", voice: "alice"
      response.dial(number: phone_number)
    end
  end

end
