require 'webmock/rspec'

module Stubs
  def self.stub_twilio_request
    WebMock.stub_request(:post, "https://api.twilio.com/2010-04-01/Accounts/#{ENV['TWILIO_ACCOUNT_SID']}/Calls.json")
        .with(body: {
          "From" => ENV['TWILIO_PHONE_NUMBER'],
          "To"   => /\+1\d{10}/,
          "Url"  => %r(http://www.example.com/calls/\d+)
        })
        .to_return(status: 201, body: "", headers: {})
  end
end
