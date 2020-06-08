class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :current_weather, :hourly_forecast, :daily_forecast
end
