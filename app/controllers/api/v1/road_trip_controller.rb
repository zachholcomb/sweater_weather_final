class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    return render json: Error.unauthorized, status: 401 if !user
    render json: RoadTripSerializer.new(
      RoadTrip.road_trip_data(road_trip_params, user)
    )
  end

  def road_trip_params
    params.permit(:origin, :destination)
  end
end