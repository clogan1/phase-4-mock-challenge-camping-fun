class SignupsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_record_unprocessable_entity_message

    def create
        signup = Signup.create!(signup_params)
        render json: signup, status: :created
    end

    private

    def signup_params
        params.permit(:time, :activity_id, :camper_id)
    end

    def render_record_unprocessable_entity_message(invalid)
        render json: {errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
end
