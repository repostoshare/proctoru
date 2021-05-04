class College < ApplicationRecord
  has_many :exams

  validates_presence_of :name
end
