class FlightsController < ApplicationController
  def index
    @flights = Flight.sort_by_departure_city
  end

  def show
    @flight = Flight.find(params[:id])  
  end
end
