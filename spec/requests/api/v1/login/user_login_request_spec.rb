require 'rails_helper'

RSpec.describe 'User login API' do
  before(:each) do
    @user = User.create!(email: "whatever@example.com", password: 'password')
  end

  it 'logins in a user with correct credentials' do
    login_params = {
      "email": "whatever@example.com",
      "password": "password"
    }

    post '/api/v1/sessions', params: login_params
    expect(response).to be_successful
    expect(response.status).to eq(200)
    login_response = JSON.parse(response.body, symbolize_names: true)

    expect(login_response[:data][:attributes][:email]).to eq("whatever@example.com")
    expect(login_response[:data][:attributes][:api_key]).not_to eq(nil)
    expect(login_response[:data][:attributes][:api_key].length).to eq(27)
  end

  it 'raises error if it cant find a user' do
    login_params = {
      "email": "whatever@example.net",
      "password": "password",
    }

    post '/api/v1/sessions', params: login_params
    login_response = JSON.parse(response.body, symbolize_names: true)
    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    expect(login_response[:data][:attributes][:message]).to eq("Can't find user with that email")
  end

  it 'raises error if password is incorrect' do
    login_params = {
      "email": "whatever@example.com",
      "password": "1234",
    }

    post '/api/v1/sessions', params: login_params
    login_response = JSON.parse(response.body, symbolize_names: true)
    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    expect(login_response[:data][:attributes][:message]).to eq("Bad credentials")
  end
end