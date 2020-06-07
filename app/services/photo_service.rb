class PhotoService
  class << self
    def get_photo_reference(city_param)
      response = conn(city_param)
      get_json(response)
    end

    private

    def conn(city_params)
      Faraday.get('https://maps.googleapis.com/maps/api/place/findplacefromtext/json?') do |req|
        req.params['key'] = ENV['GOOGLE_MAPS_API_KEY']
        req.params['input'] = city_params
        req.params['inputtype'] = 'textquery'
        req.params['fields'] = 'photos'
      end
    end

    def get_json(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end