class ExamWindow < ApplicationRecord
  belongs_to :exam

  validates_presence_of :window_start, :window_end, :status, :exam

  enum status: { active: 0, inactive: 1 }
end