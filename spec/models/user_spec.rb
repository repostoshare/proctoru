require 'rails_helper'

RSpec.describe User, type: :model do
  it "is not valid without a first name" do
    user = User.new(last_name: Faker::Name.last_name, phone_number: Faker::PhoneNumber.phone_number)
    expect(user).to_not be_valid
  end

  it "is not valid without a last name" do
    user = User.new(first_name: Faker::Name.first_name, phone_number: Faker::PhoneNumber.phone_number)
    expect(user).to_not be_valid
  end

  it "is not valid without a phone number" do
    user = User.new(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
    expect(user).to_not be_valid
  end

  it "needs a valid phone number" do
    user = User.new(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, phone_number: "notannumber")
    expect(user).to_not be_valid
  end
end
