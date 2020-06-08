class HourlyWeather
  attr_reader :hour,
              :temp,
              :icon
  
  def initialize(stats)
    @hour = format_hour(stats[:dt])
    @temp = stats[:temp].round
    @icon = get_icon_url(stats[:weather].first[:icon])
  end

  private

  def format_hour(time)
    Time.at(time).strftime('%l:%M %p')
  end

  def get_icon_url(icon)
    "http://openweathermap.org/img/wn/#{icon}@2x.png"
  end
end
