class Api::V1::AssessmentsController < ApplicationController
  wrap_parameters :assessment, include: %i[first_name last_name phone_number
                                           exam_id college_id start_time]

  def create
    assessment_request = AssessmentRequest.new(request_params["assessment"])
    if assessment_request.save
      log_request("successful")

      assessment = assessment_request.assessment
      render json: { id: assessment.id,
                     created_at: assessment.created_at,
                     updated_at: assessment.updated_at }, status: :ok
    else
      log_request("unsuccessful", assessment_request.errors)

      render json: { errors: assessment_request.errors }, status: :bad_request
    end
  end

  private

  def request_params
    params.permit(assessment: [:first_name, :last_name, :phone_number,
                              :college_id, :exam_id, :start_time])
  end
end