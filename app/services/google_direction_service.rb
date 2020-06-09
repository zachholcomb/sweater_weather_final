class GoogleDirectionService
  class << self
    def get_travel_duration(origin, destination)
      response = conn.get('/maps/api/directions/json?') do |req|
        req.params['origin'] = origin
        req.params['destination'] = destination
      end
      get_json(response)[:routes].first[:legs].first[:duration][:text]
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