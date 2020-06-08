require 'rails_helper'

RSpec.describe 'Background Photo Api' do
  it 'returns a background photo' do
    VCR.use_cassette('city_place_search_response') do
      get '/api/v1/backgrounds?location=denver,co'
      photo_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
      expected_url = "https://maps.googleapis.com/maps/api/place/photo?photoreference=CmRaAAAAOJ6vOt6yOGSPTkM92Tc2AhiovwuLYVwDOTZTF6QL2jyXgPKPh6JPg0b_i25izPBsIOs9biMxStkYr7ds3bj3vfzWkVXV3W-d0-hL0OLAJGKXm-blpQPXBtb0aHTe4Ii8EhDZ_3Mn7Xjbb2mihzwul3zCGhS7JLGFuP_yd1ma5Zx1DUu1Vu9qDg&maxwidth=1080&key=AIzaSyBJZsz3pOjf_aCzTA8vEUCV8fvEhexnUB4"
      expect(photo_response[:data][:attributes][:photo_url]).to eq(expected_url)
    end
  end
end