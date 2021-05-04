class AssessmentRequest
  include ActiveModel::Validations
  validates_with AssessmentRequestValidator

  attr_reader :assessment_params, :assessment_user, :assessment

  def initialize(assessment_params)
    @assessment_params = assessment_params
    @assessment_user = User.find_or_initialize_by(user_attributes)
    @assessment = Assessment.new(assessment_attributes)
  end

  def save
    ActiveRecord::Base.transaction do
      if self.valid? && assessment_user.valid?
        assessment_user.save if assessment_user.new_record?

        assessment.user = assessment_user
        assessment.save
      else
        raise ActiveRecord::Rollback
      end
    end
  end

  private

  def assessment_attributes
    assessment_params.slice(:college_id, :exam_id, :start_time)
  end

  def user_attributes
    { first_name: assessment_params["first_name"],
      last_name: assessment_params["last_name"],
      phone_number: assessment_params["phone_number"] }
  end
end