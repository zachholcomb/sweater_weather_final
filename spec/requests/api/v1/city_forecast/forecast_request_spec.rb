require 'rails_helper'

RSpec.describe 'Forecast request spec' do
  it 'returns a forecast for a given city' do
    VCR.use_cassette('denver_city_search') do 
      VCR.use_cassette('denver_forecast2') do
        get '/api/v1/forecast?location=denver,co'
        forecast_response = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
      end
    end
  end
end