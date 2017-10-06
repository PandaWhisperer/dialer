require 'rails_helper'

RSpec.describe "Calls", type: :request do
  fixtures :calls, :users

  before do
    @user1 = users(:earnie)
    @user2 = users(:bert)
    Stubs.stub_twilio_request
  end

  describe "POST /users/:id/call" do
    it "creates a new call" do
      expect {
        post call_user_path(@user2), params: { format: 'js' }
      }.to change { Call.count }.by(1)
    end

    it "creates a call from user 1 to user 2" do
      post call_user_path(@user2), params: { format: 'js' }
      expect(Call.last.from_user).to eq(@user1)
      expect(Call.last.to_user).to eq(@user2)
    end
  end

  describe "POST /calls/:id" do
    before do
      @call = calls(:one)
    end

    context "when user first picks up" do
      before { post call_path(@call) }

      it "responds with with voice prompt" do
        expect(response.body).to match(/Say.*press any number/)
      end

      it "waits for user input" do
        expect(response.body).to match(/Gather.*numDigits="1"/)
      end
    end

    context "when a key was pressed" do
      before do
        post call_path(@call), params: {
          Digits: '1'
        }
      end

      it "responds with a voice prompt" do
        expect(response.body).to match(/Say.*You are being connected/)
      end

      it "connects to the other party" do
        expect(response.body).to match(/Dial/)
      end
    end
  end
end
