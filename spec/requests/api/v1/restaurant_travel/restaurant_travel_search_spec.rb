require 'rails_helper'

RSpec.describe 'Restaurant API' do
  it 'can return a restaurant, the time it takes to drive there, and the forecast' do
    get '/api/v1/foodie?start=denver,co&end=pueblo,co&search=italian'
    expect(response).to be_successful
    restaurant_response = JSON.parse(response.body, symbolize_names: true)
    directions = restaurant_response[:data][:attributes][:directions]
    expect(directions[:travel_time]).to eq("1 hour 48 mins")
    expect(directions[:end_param]).to eq('pueblo,co')

    restaurant = restaurant_response[:data][:attributes][:restaurant]
    expect(restaurant[:name]).to eq("Angelo's Pizza Parlor")
    expect(restaurant[:address]).to eq("105 E Riverwalk, Pueblo 81003")

    current_weather = restaurant_response[:data][:attributes][:current_weather]
    expect(current_weather[:summary]).to eq('broken clouds')
    expect(current_weather[:temperature]).to eq(94)
  end
end