class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    return render json: Error.unauthorized, status: :unauthorized unless user
    return render json: Error.missing_params, status: :bad_request if params_missing?

    render json: RoadTripSerializer.new(
      RoadTrip.road_trip_data(road_trip_params, user)
    )
  end

  private

  def road_trip_params
    params.permit(:origin, :destination)
  end

  def params_missing?
    params[:origin].blank? || params[:destination].blank?
  end
end
