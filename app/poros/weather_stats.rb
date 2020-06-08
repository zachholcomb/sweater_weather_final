class WeatherStats
  
  def initialize(stats)
    @id = nil
    @current_weather = CurrentWeather.new(stats)
    @hourly_weather = HourlyWeather.new(stats)
  end

  def self.get_forecast(location)
    coordinates = GeocodingService.get_lat_long(location)
    stats = ForecastService.get_forecast(coordinates)
    WeatherStats.new(stats)
  end
end