class PhotoService
  class << self
    def get_photo(city_param)
      url = 'https://maps.googleapis.com/maps/api/place/photo?'
      photo_reference = "photoreference=#{get_photo_reference(city_param)}"
      maxwidth = '&maxwidth=1080'
      key = "&key=#{ENV['GOOGLE_MAPS_API_KEY']}"
      url = url + photo_reference + maxwidth + key
    end

    def get_photo_reference(city_param)
      response = conn.get('/maps/api/place/findplacefromtext/json?') do |req|
        req.params['input'] = city_param
        req.params['inputtype'] = 'textquery'
        req.params['fields'] = 'photos'
      end
      results = get_json(response)
      results[:candidates].first[:photos].first[:photo_reference]
    end

    private

    def conn
      Faraday.new('https://maps.googleapis.com') do |req|
        req.params['key'] = ENV['GOOGLE_MAPS_API_KEY']
      end
    end

    def get_json(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
