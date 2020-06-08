require 'rails_helper'

RSpec.describe 'Restaurant API' do
  it 'can return a restaurant, the time it takes to drive there, and the forecast' do
    get '/api/v1/foodie?start=denver,co&end=pueblo,co&search=italian'
    expect(response).to be_successful
  end
end