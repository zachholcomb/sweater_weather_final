class DailyWeather
    attr_reader :day,
                :min_temp,
                :max_temp,
                :description,
                :icon,
                :rain

  def initialize(stats)
    @day = format_day(stats[:dt])
    @min_temp = stats[:temp][:min].round
    @max_temp = stats[:temp][:max].round
    @description = stats[:weather].first[:main]
    @icon = get_icon_url(stats[:weather].first[:icon])
    @precipitation = calculate_precipitation(stats)
  end

  private

  def calculate_precipitation(stats)
    total = 0
    total += stats[:rain] if stats[:rain]
    total += stats[:snow] if stats[:snow]
    total.round
  end

  def format_day(time)
    Time.at(time).strftime('%A')
  end

  def get_icon_url(icon)
    "http://openweathermap.org/img/wn/#{icon}@2x.png"
  end
end