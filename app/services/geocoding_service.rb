class GeocodingService
  class << self
    def get_lat_long(city_params)
      response = conn(city_params)
      get_json(response)[:results].first[:geometry][:location]
    end

    private

    def conn(city_params)
      Faraday.get('https://maps.googleapis.com/maps/api/geocode/json?') do |req|
        req.params['key'] = ENV['GOOGLE_MAPS_API_KEY']
        req.params['address'] = city_params
      end
    end

    def get_json(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end