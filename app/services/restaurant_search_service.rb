class RestaurantSearchService
  class << self
    def return_restaurant_info(search_param, destination)
      location_id = get_location_id(destination)
      require 'pry'; binding.pry
    end

    def get_location_id(location_params)
      response = conn.get('/api/v2.1/cities?') do |req|
        req.params['q'] = location_params
      end
      get_json(response)
    end

    private

    def conn
      Faraday.new('https://developers.zomato.com') do |req|
        req.headers['user-key'] = ENV['ZOMATO_API_KEY']
      end
    end

    def get_json(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end