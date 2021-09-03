class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_message
    rescue_from ActiveRecord::RecordInvalid, with: :render_record_unprocessable_entity_message

    def index
        campers = Camper.all
        render json: campers
    end

    def show
        camper = find_camper
        render json: camper
    end

    def create
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    end

    private

    def find_camper
        Camper.find(params[:id])
    end

    def camper_params
        params.permit(:name, :age)
    end

    def render_record_not_found_message
        render json: {error: "Camper not found"}, status: :not_found
    end

    def render_record_unprocessable_entity_message(invalid)
        render json: {errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end
