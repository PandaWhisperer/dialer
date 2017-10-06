require 'rails_helper'

RSpec.describe "Calls", type: :request do
  describe "GET /calls" do
    it "works! (now write some real specs)" do
      get calls_path
      expect(response).to have_http_status(200)
    end
  end
end
