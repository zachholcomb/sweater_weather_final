class WeatherStats
  attr_reader :id,
              :current_weather,
              :hourly_forecast,
              :daily_forecast
  
  def initialize(stats)
    @id = nil
    @current_weather = CurrentWeather.new(stats)
    @hourly_forecast = get_hourly_forecast(stats)
    @daily_forecast = get_daily_forecast(stats)
  end

  def self.get_forecast(location)
    coordinates = GeocodingService.get_lat_long(location)
    stats = ForecastService.get_forecast(coordinates)
    WeatherStats.new(stats)
  end

  def get_hourly_forecast(stats)
    stats[:hourly][0..7].map do |hourly_params|
      HourlyWeather.new(hourly_params)
    end
  end

  def get_daily_forecast(stats)
    stats[:daily][0..4].map do |daily_params|
      DailyWeather.new(daily_params)
    end
  end
end