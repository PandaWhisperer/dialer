require 'rails_helper'

RSpec.describe Call, type: :model do
  fixtures :users

  it 'extracts phone numbers on create' do
    call = Call.create(from_user: users(:earnie), to_user: users(:bert))
    expect(call.from_number).to match(/\+1\d{10}/)
    expect(call.to_number).to match(/\+1\d{10}/)
  end

end
