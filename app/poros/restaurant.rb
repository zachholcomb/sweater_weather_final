class Restaurant
  attr_reader :name,
              :address
              
  def initialize(details)
    @name = details[:name]
    @address = details[:address]
  end

  def self.get_restaurant(search_param, destination)
   details = RestaurantSearchService.return_restaurant_info(search_param, destination)
   Restaurant.new(details)
  end
end