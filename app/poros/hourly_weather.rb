class HourlyWeather
  attr_reader :hour,
              :temp,
              :icon
  
  def initialize(stats)
    @hour = stats[:dt]
    @temp = stats[:temp]
    @icon = stats[:weather].first[:icon]
  end
end