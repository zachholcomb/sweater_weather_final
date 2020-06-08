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
    @current_temperature = stats[:current][:temp]
    @description = stats[:current][:weather].first[:description]
    @feels_like = stats[:current][:feels_like]
    @sunrise = stats[:current][:sunrise]
    @sunset = stats[:current][:sunset]
    @humidity = stats[:current][:humidity]
    @uv_index = stats[:current][:uvi]
    @temp_min = stats[:daily].first[:temp][:min]
    @temp_max = stats[:daily].first[:temp][:max]
    @icon = stats[:current][:weather].first[:icon]
  end
end