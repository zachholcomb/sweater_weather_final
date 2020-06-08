class TravelTimeService
  class << self
    def time_to_destination(start_param, end_param)
      response = conn.get('/maps/api/distancematrix/json?') do |req|
        req.params['origins'] = start_param
        req.params['destinations'] = end_param
      end
      get_json(response)
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