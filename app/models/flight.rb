class Flight < ApplicationRecord
  has_many :flight_passengers
  has_many :passengers, through: :flight_passengers

  def self.sort_by_departure_city
    order(departure_city: :asc)
  end

  def adult_passengers
    passengers.where('age >= 18')
  end
end
