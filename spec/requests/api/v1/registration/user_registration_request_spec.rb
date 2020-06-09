require 'rails_helper'

RSpec.describe 'User Registration API' do
  it 'can register a user via post request' do
    headers = {
      'Content-Type': 'application/json'
    }

    expect(User.all.length).to eq(0)

    user_params =  {
    "email": "whatever@example.com",
    "password": "password",
    "password_confirmation": "password"
    }

    post '/api/v1/users', params: user_params.to_json, headers: headers

    expect(response).to be_successful
    expect(response.status).to eq(201)
    user_response = JSON.parse(response.body, symbolize_names: true)

    expect(User.all.length).to eq(1)
    expect(user_response[:data][:attributes][:email]).to eq("whatever@example.com")
    expect(user_response[:data][:attributes][:api_key]).to_not eq(nil)
    expect(user_response[:data][:attributes][:api_key].length).to eq(27)
  end

  it 'cant register a user with missing params' do
    expect(User.all.length).to eq(0)
    user_params =  {
    "email": "whatever@example.com"
    }
    post '/api/v1/users', params: user_params
    error_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).not_to be_successful
    expect(response.status).to eq(400)
    expect(User.all.length).to eq(0)
    expect(error_response[:data][:attributes][:message]).to eq('Missing required fields')
  end

  it 'cant register a user if a user exists with the same email' do
    user = User.create!(email: "whatever@example.com", password: 'password')
    expect(User.all.length).to eq(1)

    user_params =  {
    "email": "whatever@example.com",
    "password": "password",
    "password_confirmation": "password"
    }

    post '/api/v1/users', params: user_params
    error_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).not_to be_successful
    expect(response.status).to eq(400)
    expect(error_response[:data][:attributes][:message]).to eq('Email already exists')
    expect(User.all.length).to eq(1)
  end

  it 'cant register a user if a the password params submitted dont match' do
    expect(User.all.length).to eq(0)
    user_params =  {
    "email": "whatever@example.com",
    "password": "password",
    "password_confirmation": "dog"
    }

    post '/api/v1/users', params: user_params
    error_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).not_to be_successful
    expect(response.status).to eq(400)
    expect(User.all.length).to eq(0)
    expect(error_response[:data][:attributes][:message]).to eq('Password and pasword confirmation dont match')
  end
end