class CurrentWeather
  attr_reader :current_temperature,
              :description,
              :feels_like,
              :sunrise,
              :sunset,
              :humidity,
              :uv_index,
              :temp_min,
              :temp_max

  def initialize(stats)
    @current_temperature = stats[:temp].round
    @description = stats[:weather].first[:main]
    @feels_like = stats[:feels_like].round
    @date = format_current_time(stats[:dt])
    @sunrise = format_clock_time(stats[:sunrise])
    @sunset = format_clock_time(stats[:sunset])
    @humidity = stats[:humidity]
    @uv_index = format_uv_index(stats[:uvi].round)
    @icon = get_icon_url(stats[:weather].first[:icon])
  end

  private

  def format_uv_index(uvi)
    return "#{uvi} (extreme)" if uvi >= 11
    return "#{uvi} (very high)" if uvi >= 8
    return "#{uvi} (high)" if uvi >= 6
    return "#{uvi} (moderate)" if uvi >= 3

    "#{uvi} (low)"
  end

  def format_current_time(time)
    Time.at(time).strftime('%l:%M %p, %B %e')
  end

  def format_clock_time(time)
    Time.at(time).strftime('%l:%M')
  end

  def get_icon_url(icon)
    "http://openweathermap.org/img/wn/#{icon}@2x.png"
  end
end
