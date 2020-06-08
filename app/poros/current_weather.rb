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
    @current_temperature = stats[:current][:temp].round
    @description = stats[:current][:weather].first[:main]
    @feels_like = stats[:current][:feels_like].round
    @date = format_current_time(stats[:current][:dt])
    @sunrise = format_clock_time(stats[:current][:sunrise])
    @sunset = format_clock_time(stats[:current][:sunset])
    @humidity = stats[:current][:humidity]
    @uv_index = format_uv_index(stats[:current][:uvi].round)
    @temp_min = stats[:daily].first[:temp][:min].round
    @temp_max = stats[:daily].first[:temp][:max].round
    @icon = get_icon_url(stats[:current][:weather].first[:icon])
  end

  private

  def format_uv_index(uv)
    return "#{uv} (extreme)" if uv >= 11
    return "#{uv} (very high)" if uv >= 8
    return "#{uv} (high)" if uv >= 6
    return "#{uv} (moderate)" if uv >= 3
    "#{uv} (low)"
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