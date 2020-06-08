class Restaurant
  attr_reader :name,
              :address
              
  def initialize(details)
    @name = details[:name]
    @address = details[:address]
  end

  def get_resaurant(search_params)
   details = RestaurantSearchService.return_restaurant_info(search_params)
   Restaurant.new(details)
  end
end