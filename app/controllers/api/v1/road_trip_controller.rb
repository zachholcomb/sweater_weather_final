class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    return render json: Error.unauthorized, status: 401 if !user
    return render json: Error.missing_params, status: 400 if params_missing?
    render json: RoadTripSerializer.new(
      RoadTrip.road_trip_data(road_trip_params, user)
    )
  end

  private

  def road_trip_params
    params.permit(:origin, :destination)
  end

  def params_missing?
    params[:origin].nil? || params[:destination].nil? || 
    params[:origin].empty? || params[:destination].empty?
  end
end