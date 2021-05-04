class Exam < ApplicationRecord
  belongs_to :college
  has_many :exam_windows

  validates_presence_of :name
end