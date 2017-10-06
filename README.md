# Twilio Dialer

## Background

This is a rather simple proof-of-concept to use Twilio to initiate calls between users without sharing their phone numbers.

The idea is this: when a user wants to call another user, the app will use Twilio to first call the calling user, and when he or she picks up, connect them to the other user.

## Installation

The usual. Run `bundle install` followed by `rake db:setup`.

You'll need a Twilio API key and secret, as well as a phone number to use for outgoing calls. All three go in `config/application.yml` (see `config/application.yml.sample` for correct format).

## Running

Use `bundle exec rails server` to run a server, and `bundle exec rake spec` to run tests.

## IMPORTANT NOTES

The seeds file will generate a bunch of random users with random numbers. Please don't just click and call those! Either add a new user with your own phone number of modify one of the seeds.

Also, there is currently no user authentication, so the app will simply assume that the first user is logged in. This user will receive a call that is then connected to the target user. **Make sure that first user has a phone number YOU own.**

## To Do / Ideas

- User authentication (currently stubbed out)
- Call length monitoring. Twilio can make callbacks when a call is picked up and finished, which would allow the app to log the length of each call performed (e.g. for billing purposes)
- Call back if busy: if the called user does not pick up, we could run a voice prompt asking the user if they want to schedule a callback. The app could then automatically try and dial the number again in an hour or so.
