require 'rails_helper'

RSpec.describe 'Google City Image Service' do
  it 'returns the right image' do
    VCR.use_cassette('city_place_search_response') do
      adress = 'denver,co'
      response = PhotoService.get_photo_reference(adress)
      expected = "CmRaAAAAOJ6vOt6yOGSPTkM92Tc2AhiovwuLYVwDOTZTF6QL2jyXgPKPh6JPg0b_i25izPBsIOs9biMxStkYr7ds3bj3vfzWkVXV3W-d0-hL0OLAJGKXm-blpQPXBtb0aHTe4Ii8EhDZ_3Mn7Xjbb2mihzwul3zCGhS7JLGFuP_yd1ma5Zx1DUu1Vu9qDg"
      expect(response[:candidates].first[:photos].first[:photo_reference]).to eq(expected)
    end
  end
end