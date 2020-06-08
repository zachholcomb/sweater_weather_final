class DailyWeather
    attr_reader :day,
                :min_temp,
                :max_temp,
                :description,
                :icon,
                :rain

  def initialize(stats)
    @day = stats[:dt]
    @min_temp = stats[:temp][:min]
    @max_temp = stats[:temp][:max]
    @description = stats[:weather].first[:description]
    @icon = stats[:weather].first[:description]
    @rain = stats[:rain]
  end
end