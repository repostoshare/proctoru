require 'rails_helper'

describe "Api::V1::AssessmentsController", :type => :request do
  let(:json_type) { { 'CONTENT_TYPE' => 'application/json' } }

  describe "#create" do
    context 'valid parameters' do
      let(:college) { FactoryBot.create(:college) }
      let(:exam) { FactoryBot.create(:exam, college: college) }

      context 'new user' do
        let(:assessment_request) do 
          FactoryBot.build(:assessment_request, college_id: college.id, exam_id: exam.id )
        end

        before do
          post '/api/v1/assessments', params: assessment_request.to_json, headers: json_type
        end
        
        it "creates records successfully" do
          expect(Assessment.count).to eq(1)
          expect(User.count).to eq(1)
          user = User.last
          assessment = Assessment.last
          expect(assessment.user).to eq(user)
        end
  
        it "returns 200 OK response" do
          expect(response).to have_http_status(:success)
        end

        it "logs the request" do
          expect(ApiRequest.count).to eq(1)
          expect(ApiRequest.last.request_errors).to eq("null")
        end
      end

      context 'existing user' do
        let(:existing_user) { FactoryBot.create(:user) }
        let(:request_with_existing_user) do
          FactoryBot.build(:assessment_request, 
                           first_name: existing_user.first_name,
                           last_name: existing_user.last_name,
                           phone_number: existing_user.phone_number,
                           college_id: college.id,
                           exam_id: exam.id)
        end
  
        before do
          post '/api/v1/assessments', params: request_with_existing_user.to_json, headers: json_type
        end
        
        it "creates records successfully" do
          expect(Assessment.count).to eq(1)
          expect(User.count).to eq(1)
          user = User.last
          assessment = Assessment.last
          expect(assessment.user).to eq(user)
        end
  
        it "returns 200 OK response" do
          expect(response).to have_http_status(:success)
        end

        it "logs the request" do
          expect(ApiRequest.count).to eq(1)
          expect(ApiRequest.last.request_errors).to eq("null")
        end
      end
    end

    context 'invalid parameters' do
      let(:college) { FactoryBot.create(:college) }
      let(:exam) { FactoryBot.create(:exam) }

      before do
        post '/api/v1/assessments', params: assessment_request.to_json, headers: json_type
      end

      context 'no college present' do
        let(:assessment_request) do
          FactoryBot.build(:assessment_request, college_id: nil)
        end        
        
        it "does not create relevant recordss" do
          expect(Assessment.count).to eq(0)
          expect(User.count).to eq(0)
        end
  
        it "returns 400 response" do
          expect(response).to have_http_status(:bad_request)
        end

        it "logs the request" do
          expect(ApiRequest.count).to eq(1)
          expect(ApiRequest.last.request_errors).not_to be_nil
        end
      end

      context 'no exam present' do
        let(:assessment_request) do
          FactoryBot.build(:assessment_request, college_id: college.id, exam_id: nil)
        end      
        
        it "does not create relevant records" do
          expect(Assessment.count).to eq(0)
          expect(User.count).to eq(0)
        end
  
        it "returns 400 response" do
          expect(response).to have_http_status(:bad_request)
        end

        it "logs the request" do
          expect(ApiRequest.count).to eq(1)
          expect(ApiRequest.last.request_errors).not_to be_nil
        end
      end      

      context 'exam does not belong to college' do
        let(:assessment_request) do
          FactoryBot.build(:assessment_request, college_id: college.id, exam_id: exam.id)
        end      
        
        it "does not create relevant records" do
          expect(exam.college).not_to eq(college)
          expect(Assessment.count).to eq(0)
          expect(User.count).to eq(0)
        end
  
        it "returns 400 response" do
          expect(response).to have_http_status(:bad_request)
        end

        it "logs the request" do
          expect(ApiRequest.count).to eq(1)
          expect(ApiRequest.last.request_errors).not_to be_nil
        end
      end

      context 'invalid user data' do
        let(:assessment_request) do
          FactoryBot.build(:assessment_request,
                           college_id: exam.college.id,
                           exam_id: exam.id,
                           phone_number: 'notaphonenumber')
        end      
        
        it "does not create relevant records" do
          expect(Assessment.count).to eq(0)
          expect(User.count).to eq(0)
        end
  
        it "returns 400 response" do
          expect(response).to have_http_status(:bad_request)
        end

        it "logs the request" do
          expect(ApiRequest.count).to eq(1)
          expect(ApiRequest.last.request_errors).not_to be_nil
        end
      end

      context 'user cannot be associated with exam' do
        let(:existing_user) { FactoryBot.create(:user) }
        let(:level_2_exam) { FactoryBot.create(:level_2_exam) }
        let(:assessment_request) do
          FactoryBot.build(:assessment_request,
                           college_id: level_2_exam.college.id,
                           exam_id: level_2_exam.id,
                           phone_number: existing_user.phone_number,
                           first_name: existing_user.first_name,
                           last_name: existing_user.last_name)
        end      
        
        it "does not create relevant records" do
          expect(Assessment.count).to eq(0)
          expect(User.count).to eq(1)
        end
  
        it "returns 400 response" do
          expect(response).to have_http_status(:bad_request)
        end

        it "logs the request" do
          expect(ApiRequest.count).to eq(1)
          expect(ApiRequest.last.request_errors).not_to be_nil
        end
      end

      context 'invalid start time' do
        let(:expired_exam) { FactoryBot.create(:exam_with_expired_window) }
        let(:assessment_request) do
          FactoryBot.build(:assessment_request,
                           college_id: expired_exam.college.id,
                           exam_id: expired_exam.id)
        end      
        
        it "does not create relevant records" do
          expect(Assessment.count).to eq(0)
          expect(User.count).to eq(0)
        end
  
        it "returns 400 response" do
          expect(response).to have_http_status(:bad_request)
        end

        it "logs the request" do
          expect(ApiRequest.count).to eq(1)
          expect(ApiRequest.last.request_errors).not_to be_nil
        end
      end
    end
  end
end
