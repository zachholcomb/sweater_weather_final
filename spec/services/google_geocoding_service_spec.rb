require 'rails_helper'

RSpec.describe 'Google geocoding service' do
  it 'can return lat and long' do
    VCR.use_cassette('denver_city_search') do
      adress = 'denver,co'
      json_city_search_resp = File.read('spec/fixtures/test_responses/city_search.json')
      expected = JSON.parse(json_city_search_resp, symbolize_names: true)
      expect(GeocodingService.get_lat_long(adress)).to eq(expected)
    end
  end
end