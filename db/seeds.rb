require 'faker'

def fake_email
  Faker::Internet.unique.email
end

def fake_name
  Faker::Name.unique.name
end

def fake_phone_no
  "+1#{Faker::PhoneNumber.phone_number.gsub(/\s|-|\.|\(|\)/, '').first(10)}"
end

20.times do |i|
  User.create(email: fake_email, name: fake_name, phone: fake_phone_no,
             password: 'test1234', password_confirmation: 'test1234')
end
