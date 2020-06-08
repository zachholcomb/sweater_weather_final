require 'rails_helper'

RSpec.describe 'Forecast request spec' do
  it 'returns a forecast for a given city' do
    VCR.use_cassette('denver_city_search') do 
      VCR.use_cassette('denver_forecast2') do
        get '/api/v1/forecast?location=denver,co'
        forecast_response = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(forecast_response[:data][:attributes][:current_weather]).not_to eq(nil)
        expect(forecast_response[:data][:attributes][:hourly_forecast]).not_to eq(nil)
        expect(forecast_response[:data][:attributes][:daily_forecast]).not_to eq(nil)
      end
    end
  end
end