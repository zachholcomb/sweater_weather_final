class FoodieSerializer
  include FastJsonapi::ObjectSerializer
  attributes :directions, :restaurant, :current_weather
end
