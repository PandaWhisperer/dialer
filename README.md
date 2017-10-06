# Twilio Dialer

## Background

This is a rather simple proof-of-concept to use Twilio to initiate calls between users without sharing their phone numbers.

The idea is this: when a user wants to call another user, the app will use Twilio to first call the calling user, and when he or she picks up, connect them to the other user.

## Installation

The usual. Run `bundle install` followed by `rake db:setup`.

You'll need a Twilio API key and secret, as well as a phone number to use for outgoing calls. All three go in `config/application.yml` (see `config/application.yml.sample` for correct format).

## Running

Use `bundle exec rails server` to run a server, and `bundle exec rake spec` to run tests.
