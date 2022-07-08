class ApplicationController < ActionController::API
  def forecast
    params.require(:location)

    data, status, message = WeatherApiService.new(params[:location]).forecast
    render json: { message: message, data: data }, status: status
  end

  def history
    params.require(%i[location start_date end_date])

    data, status, message = WeatherApiService.new(params[:location]).history(params[:start_date], params[:end_date])
    render json: { message: message, data: data }, status: status
  end
end
