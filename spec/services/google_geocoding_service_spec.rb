require 'rails_helper'

RSpec.describe 'Google geocoding service' do
  it 'can return lat and long' do
    VCR.use_cassette('denver_city_search') do
      adress = 'denver,co'
      expected = {:lat=>39.7392358, :lng=>-104.990251}
      expect(GeocodingService.get_lat_long(adress)).to eq(expected)
    end
  end
end