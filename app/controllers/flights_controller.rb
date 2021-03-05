class FlightsController < ApplicationController
  def index
    @flights = Flight.sort_by_departure_city
    # @flights = Flight.sort_by_passenger_then_depart
  end

  def show
    @flight = Flight.find(params[:id])
  end
end
