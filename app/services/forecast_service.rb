class ForecastService
  class << self
    def get_forecast(city_params)
      response = conn(city_params)
      get_json(response)
    end

    private

    def conn(city_params)
      Faraday.get('https://api.openweathermap.org/data/2.5/onecall?') do |req|
        req.params['appid'] = ENV['WEATHER_API_KEY']
        req.params['lat'] = city_params[:lat]
        req.params['lon'] = city_params[:lng]
        req.params['exclude'] = 'minutely'
        req.params['units'] = 'imperial'
      end
    end

    def get_json(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
