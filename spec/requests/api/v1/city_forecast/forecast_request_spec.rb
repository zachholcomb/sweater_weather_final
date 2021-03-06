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

  it 'returns current weather in the correct format' do
    VCR.use_cassette('denver_city_search') do 
      VCR.use_cassette('denver_forecast2') do
        get '/api/v1/forecast?location=denver,co'
        forecast_response = JSON.parse(response.body, symbolize_names: true)
        current = forecast_response[:data][:attributes][:current_weather]
        expect(current[:current_temperature]).to eq(88)
        expect(current[:description]).to eq('Clear')
        expect(current[:feels_like]).to eq(79)
        expect(current[:date]).to eq("11:47 PM, June  7")
        expect(current[:sunrise]).to eq("11:32")
        expect(current[:sunset]).to eq(" 2:26")
        expect(current[:humidity]).to eq(9)
        expect(current[:uv_index]).to eq('11 (extreme)')
        expect(current[:visibility]).to eq('n/a')
        expect(current[:icon]).to eq("http://openweathermap.org/img/wn/01d@2x.png")
      end
    end
  end

  it "returns visibility and low uvi" do
    VCR.use_cassette('denver_city_search') do 
      VCR.use_cassette('test_forecast') do
        get '/api/v1/forecast?location=denver,co'
        forecast_response = JSON.parse(response.body, symbolize_names: true)
        current = forecast_response[:data][:attributes][:current_weather]
        expect(current[:uv_index]).to eq('2 (low)')
        expect(current[:visibility]).to eq(2)
      end
    end
  end

  it 'returns daily forecast details' do
    VCR.use_cassette('denver_city_search') do 
      VCR.use_cassette('denver_forecast2') do
        get '/api/v1/forecast?location=denver,co'
        forecast_response = JSON.parse(response.body, symbolize_names: true)
        daily = forecast_response[:data][:attributes][:daily_forecast].first

        expect(daily[:day]).to eq('Sunday')
        expect(daily[:min_temp]).to eq(74)
        expect(daily[:max_temp]).to eq(88)
        expect(daily[:description]).to eq('Clear')
        expect(daily[:precipitation]).to eq(0)
      end
    end
  end

  it 'returns hourly forecast details' do
    VCR.use_cassette('denver_city_search') do 
      VCR.use_cassette('denver_forecast2') do
        get '/api/v1/forecast?location=denver,co'
        forecast_response = JSON.parse(response.body, symbolize_names: true)
        hourly = forecast_response[:data][:attributes][:hourly_forecast].first
       
        expect(hourly[:hour]).to eq('11:00 PM')
        expect(hourly[:temp]).to eq(88)
        expect(hourly[:icon]).to eq("http://openweathermap.org/img/wn/01d@2x.png")
      end
    end
  end
end