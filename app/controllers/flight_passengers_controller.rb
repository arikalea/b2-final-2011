class FlightPassengersController < ApplicationController
  def destroy
    flight_passenger = FlightPassenger.find_by(
      flight_id: params[:format],
      passenger_id: params[:id]
    )
    flight_passenger.destroy
    redirect_to flight_path(params[:format])
  end
end
