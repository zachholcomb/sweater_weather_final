class RestaurantSearchService
  class << self
    def return_restaurant_info(search_param, destination)
      location_id = get_location_id(destination)
      cuisine_id = get_cuisine_id(location_id, search_param)
      response = conn.get('/api/v2.1/search?') do |req|
        req.params['entity_id'] = location_id
        req.params['entity_type'] = 'city'
        req.params['cuisines'] = cuisine_id
      end
      get_json(response)[:restaurants].first
    end

    def get_location_id(location_params)
      response = conn.get('/api/v2.1/cities?') do |req|
        req.params['q'] = location_params
      end
      get_json(response)[:location_suggestions].first[:id]
    end

    def get_cuisine_id(location_id, search_param)
      response = conn.get('/api/v2.1/cuisines?') do |req|
        req.params['city_id'] = location_id
      end
      parse_response(get_json(response), search_param)
    end


    def parse_response(results, search_param)
      results[:cuisines].each do |cuisine_hash|
        if cuisine_hash[:cuisine][:cuisine_name].downcase == search_param.downcase
          return cuisine_hash[:cuisine][:cuisine_id]
        end
      end
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