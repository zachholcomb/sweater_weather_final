require 'rails_helper'

RSpec.describe 'Road Trip API' do
  before(:each) do
    @user = User.create!(email: "whatever@example.com", password: 'password')
  end

  it 'can create a new road trip from a user' do
    VCR.use_cassette('pueblo_direction_service') do
      VCR.use_cassette('pueblo_forecast') do
        expect(RoadTrip.all.length).to eq(0)
        road_trip_param =  {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": "#{@user.api_key}"
        }

        post '/api/v1/road_trip', params: road_trip_param
        expect(response).to be_successful 
        road_trip_response = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

        expect(RoadTrip.all.length).to eq(1)
        expect(User.last.road_trips.length).to eq(1)
        expect(road_trip_response[:origin]).to eq('Denver,CO')
        expect(road_trip_response[:destination]).to eq('Pueblo,CO')
        expect(road_trip_response[:travel_time]).to eq('1 hour 48 mins')
        expect(road_trip_response[:temp]).to eq(55)
        expect(road_trip_response[:weather_summary]).to eq('Clear')
      end
    end
  end

  it 'cant create a user with an incorrect api' do
    VCR.use_cassette('pueblo_direction_service') do
      VCR.use_cassette('pueblo_forecast') do
        expect(RoadTrip.all.length).to eq(0)
        road_trip_param =  {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": "jgn983hy48thw9begh98h4539h4"
        }

        post '/api/v1/road_trip', params: road_trip_param
        expect(response).not_to be_successful
        expect(response.status).to eq(401)
        error_response = JSON.parse(response.body, symbolize_names: true)
        expect(error_response[:data][:attributes][:message]).to eq('Unauthorized')
      end
    end
  end
end