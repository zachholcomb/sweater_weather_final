class Foodie
  attr_reader :id,
              :directions,
              :restaurant

  def initialize(params)
    @id = nil
    @directions = TripInfo.get_trip_info(params[:start], params[:end])
    @restaurant = Restaurant.get_restaurant(params[:search])
  end
end