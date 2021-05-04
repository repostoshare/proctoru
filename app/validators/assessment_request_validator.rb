class AssessmentRequestValidator < ActiveModel::Validator
  ALLOWED_KEYS = %w[first_name last_name phone_number
                    college_id exam_id start_time]

  attr_reader :record, :params, :user, :missing_keys

  def validate(record)
    @record = record
    @params = record.assessment_params
    @user = record.assessment_user
    @missing_keys = ALLOWED_KEYS - (ALLOWED_KEYS & params.keys)

    validate_parameters_presence

    validate_user

    college = College.includes(:exams).find_by(id: params["college_id"])
    validate_college(college)

    exam = Exam.includes(:exam_windows).find_by(id: params["exam_id"])
    validate_exam(exam, college)
    validate_user_level_exam_level(exam)

    validate_assessment_start_time(exam)
  end

  private

  def validate_parameters_presence
    if missing_keys.any?
      record.errors.add(:missing_parameters,
                        "This assessment is missing parameters: #{missing_keys.join(", ")}")
    end
  end

  def validate_user
    if !user.valid?
      record.errors.add(:user,
                        "The user could not be found or created with the given attributes")
    end
  end

  def validate_college(college)
    if !college && !missing_keys.include?("college_id")
      record.errors.add(:college,
                        "The college could not be found with id: #{params["college_id"]}")
    end
  end

  def validate_exam(exam, college)
    if !exam && !missing_keys.include?("exam_id")
      record.errors.add(:exam,
                        "The exam could not be found with id: #{params["exam_id"]}")
    elsif college && !college.exams.pluck(:id).include?(params["exam_id"].to_i)
      record.errors.add(:exam,
                        "The exam #{params["exam_id"]} is not offered" \
                        "by college #{params["college_id"]}")
    end
  end

  def validate_user_level_exam_level(exam)
    if exam && exam.level > user.level
      record.errors.add(:exam_eligibility,
                        "The user is not eligible to take this exam")
    end
  end

  def validate_assessment_start_time(exam)
    valid_windows = ExamWindow.where(exam: exam)
                       .where("? BETWEEN window_start AND window_end", params["start_time"])
    if exam && valid_windows.empty?
      record.errors.add(:exam_eligibility,
                        "This exams available time period has ended")
    end
  end
end