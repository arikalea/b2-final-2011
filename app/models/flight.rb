class Flight < ApplicationRecord
  has_many :flight_passengers
  has_many :passengers, through: :flight_passengers

  def self.sort_by_departure_city
    order(departure_city: :asc)
  end

  def adult_passengers
    passengers.where('age >= 18')
  end

  def avg_adult_age
    passengers.where('age >= 18').average(:age)
  end

  # def self.sort_by_passenger_then_depart
  #   joins(:passengers)
  #   .sum('flight.passengers')
  #   .order(departure_city: :asc)
  # end
end
