class WeatherApiService
  require 'open-uri'

  URL = 'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline'

  def initialize(location)
    @location = location
  end

  # =========================================
  # returns 7 days weather forecast
  # =========================================
  def forecast
    forecast_uri = "#{URL}/#{@location}/next7days?include=days&key=#{api_key}"

    call(forecast_uri)
  end

  # =========================================
  # accepts start and end date
  # formatted 'yyyy-MM-dd'
  #
  # returns weather history within date range
  # =========================================
  def history(start_date, end_date)
    begin
      start_date = sanitize_date(start_date)
      end_date = sanitize_date(end_date)
      history_uri = "#{URL}/#{@location}/#{start_date}/#{end_date}?include=days&key=#{api_key}"

      call(history_uri)
    rescue ArgumentError => e
      return [{}, 500, e.message]
    end
  end

  private

  def api_key
    ENV['WEATHER_API_KEY']
  end

  def sanitize_date(date)
    Date.parse(date).strftime('%Y-%m-%d')
  end

  def call(uri)
    begin
      result = URI.parse(uri).read
      [JSON.parse(result)] + result.status
    rescue OpenURI::HTTPError => e
      [{}] + e.io.status
    end
  end
end
