require 'rails_helper'

RSpec.describe 'Forecast Service' do
  it 'can return a forecast for a given city' do
    VCR.use_cassette('denver_forecast') do
      city_params = { lat: '39.7392358', lng: '-104.990251'}
      response = ForecastService.get_forecast(city_params)
      lat = 39.74
      lon = -104.99
      expect(response[:lat]).to eq(lat)
      expect(response[:lon]).to eq(lon)
      expect(response[:hourly]).to_not eq(nil)
    end
  end
end