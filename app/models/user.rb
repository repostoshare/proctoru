class User < ApplicationRecord
  validates_presence_of :first_name, :last_name, :phone_number
  validates_uniqueness_of :phone_number
  validates_format_of :phone_number,
                      with: /\A([+])?([^\d]?\d){10,18}\z/,
                      message: "This phone number is not in a valid format."
end
