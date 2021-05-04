class ApiRequest < ApplicationRecord
  enum status: { successful: 0, unsuccessful: 1 }
end