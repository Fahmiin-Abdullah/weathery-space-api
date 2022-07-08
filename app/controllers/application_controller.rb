class ApplicationController < ActionController::API
  def forecast
    @data = WeatherApiService.new(params[:location]).forecast(params[:days])
    render json: { message: 'Forecast data' }, status: :ok
  end

  def history
    params.require(%i[start_date end_date])

    @data = WeatherApiService.new(params[:location]).history(params[:start_date], params[:end_date])
    render json: { message: 'History data' }, status: :ok
  end
end
