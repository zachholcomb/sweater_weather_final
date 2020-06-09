class RoadTrip < ApplicationRecord
  validates :origin, presence: true
  validates :destination, presence: true
  validates :travel_time, presence: true
  validates :temp, presence: true
  validates :weather_summary, presence: true
  belongs_to :user

  class << self
    def road_trip_data(params, user)
      travel_time = travel_duration(params)
      weather_data = get_road_trip_weather(params[:destination], travel_time)
      create_road_trip(params, travel_time, weather_data, user)
    end

    def travel_duration(params)
      GoogleDirectionService.get_travel_duration(params[:origin], params[:destination])
    end

    def get_road_trip_weather(location, time)
      arrival_time = Time.now + time[:value]
      coordinates = GeocodingService.get_lat_long(location)
      stats = ForecastService.get_forecast(coordinates)
      weather = stats[:hourly].find do |forecast|
        hour_later = Time.at(forecast[:dt] + 3600)
        hour_later > arrival_time && arrival_time >= Time.at(forecast[:dt])
      end
    end

    def create_road_trip(params, travel_time, weather_data, user)
      user.road_trips.create(
        origin: params[:origin],
        destination: params[:destination],
        travel_time: travel_time[:text],
        temp: weather_data[:temp].round,
        weather_summary: weather_data[:weather].first[:main]
      )
    end
  end
end
