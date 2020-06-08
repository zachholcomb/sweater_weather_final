class TripWeather
  def initialize(details)
    @summary = details[:weather].first[:description]
    @temperature = details[:main][:temp].round
  end

  def self.get_destination_weather(location)
    details = CurrentWeatherService.get_current_weather(location)
    TripWeather.new(details)
  end
end