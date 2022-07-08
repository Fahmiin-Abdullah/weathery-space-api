class WeatherApiService
  URL = 'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/'

  def initialize(location)
    @location = location
  end

  def forecast(days = 7)
    # return default 7 days forecast
  end

  def history(start_date, end_date)
    # return weather record within date range
  end

  private

  def api_key
    ENV['WEATHER_API_KEY']
  end
end
