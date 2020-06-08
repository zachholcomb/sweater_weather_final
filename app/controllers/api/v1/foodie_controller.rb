class Api::V1::FoodieController < ApplicationController
  def index
    render json: FoodieSerializer.new(
      Foodie.get_restaurant_trip_details(foodie_params))
  end

  private

  def foodie_params
    params.permit(:start, :end, :search)
  end
end