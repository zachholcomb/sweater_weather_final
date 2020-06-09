require 'rails_helper' 

RSpec.describe 'Google Directions Service' do
  it 'returns a duration time given an origin and endpoint' do
    VCR.use_cassette('pueblo_direction_service') do
      origin = 'Denver,CO'
      destination = 'Pueblo,CO'
      expected = "1 hour 48 mins"
      expect(GoogleDirectionService.get_travel_duration(origin, destination)).to eq(expected)
    end
  end
end