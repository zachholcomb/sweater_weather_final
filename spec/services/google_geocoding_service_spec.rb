require 'rails_helper'

RSpec.describe 'Google geocoding service' do
  it 'can return lat and long' do
    adress = 'denver,co'
    json_city_search_resp = File.read('spec/fixtures/city_search.json')
    expect(GeocodingService.get_lat_long).to eq(json_city_search_resp)
  end
end