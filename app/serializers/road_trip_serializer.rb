class RoadTripSerializer
  include FastJsonapi::ObjectSerializer
  attributes :origin,
             :destination,
             :travel_time,
             :temp,
             :weather_summary
end
