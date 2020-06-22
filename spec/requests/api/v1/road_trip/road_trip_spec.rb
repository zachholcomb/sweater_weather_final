require 'rails_helper'

RSpec.describe 'Road Trip API' do
  before(:each) do
    @time_now = Time.mktime(2020,6,9)
    allow(Time).to receive(:now).and_return(@time_now)
    @user = User.create!(email: "whatever@example.com", password: 'password')
    @headers = {
      'Content-Type': 'application/json'
    }
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

        post '/api/v1/road_trip', params: road_trip_param.to_json, headers: @headers
        expect(response).to be_successful 
        expect(response.status).to eq(200)
        road_trip_response = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

        expect(RoadTrip.all.length).to eq(1)
        expect(User.last.road_trips.length).to eq(1)
        expect(road_trip_response[:origin]).to eq('Denver,CO')
        expect(road_trip_response[:destination]).to eq('Pueblo,CO')
        expect(road_trip_response[:travel_time]).to eq('1 hour 48 mins')
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

        post '/api/v1/road_trip', params: road_trip_param.to_json, headers: @headers
        expect(response).not_to be_successful
        expect(response.status).to eq(401)
        error_response = JSON.parse(response.body, symbolize_names: true)
        expect(error_response[:data][:attributes][:message]).to eq('Unauthorized')
      end
    end
  end

  it 'cant create a user with a road trip with missing parameters' do
    VCR.use_cassette('pueblo_direction_service') do
      VCR.use_cassette('pueblo_forecast') do
        expect(RoadTrip.all.length).to eq(0)
        road_trip_param =  {
        "origin": "",
        "destination": "Pueblo,CO",
        "api_key": "#{@user.api_key}"
        }

        post '/api/v1/road_trip', params: road_trip_param.to_json, headers: @headers
        expect(response).not_to be_successful
        expect(response.status).to eq(400)
        error_response = JSON.parse(response.body, symbolize_names: true)
        expect(error_response[:data][:attributes][:message]).to eq('Missing required fields')
      end
    end
  end
end