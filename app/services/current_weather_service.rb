class CurrentWeatherService
  class << self
    def get_current_weather(location)
      response = conn(location)
      get_json(response)
    end

    private

    def conn(city_params)
      Faraday.get('https://api.openweathermap.org/data/2.5/weather?') do |req|
        req.params['appid'] = ENV['WEATHER_API_KEY']
        req.params['q'] = city_params
        req.params['units'] = 'imperial'
      end
    end

    def get_json(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end