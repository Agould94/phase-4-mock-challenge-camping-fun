class CampersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  before_action :set_camper, only: [:show, :update, :destroy]

  # GET /campers
  def index
    campers = Camper.all

    render json: campers
  end

  # GET /campers/1
  def show
    camper = set_camper
    render json: camper, serializer: CamperWithActivitiesSerializer
  end

  # POST /campers
  def create
    @camper = Camper.create!(camper_params)
    render json: @camper, status: :created
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_camper
      Camper.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def camper_params
      params.permit(:name, :age)
    end

    def render_not_found_response
      render json: {error: "Camper not found"}, status: :not_found
    end

    def render_unprocessable_entity_response(exception)
      render json: {errors: exception.record.errors.full_messages}, status: :unprocessable_entity
    end

end
