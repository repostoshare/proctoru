class Assessment < ApplicationRecord
  belongs_to :user
  belongs_to :college
  belongs_to :exam
end
