class TripInfo
  attr_reader :travel_time,
              :end_param
              
  def initialize(travel_time, end_param)
    @travel_time = travel_time
    @end_param = end_param
  end

  def self.get_trip_info(start_param, end_param)
    travel_time = TravelTimeService.time_to_destination(start_param, end_param)
    TripInfo.new(travel_time, end_param)
  end
end