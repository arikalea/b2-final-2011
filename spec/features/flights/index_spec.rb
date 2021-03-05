require 'rails_helper'

RSpec.describe 'As a visitor' do
  before :each do
    @flight_1 = Flight.create(number: 111, date: "01/01/01", time: "1:00pm", departure_city: "SLC", arrival_city: "Denver")
    @flight_2 = Flight.create(number: 222, date: "02/02/02", time: "2:00pm", departure_city: "LA", arrival_city: "Seattle")
    @flight_3 = Flight.create(number: 333, date: "03/03/03", time: "3:00pm", departure_city: "Dallas", arrival_city: "NYC")
    visit flights_path
  end

  describe 'When I visit Flights Index page' do
    it 'I see each flight in the system including its number, departure city, and arrival city' do
      within("#flight-#{@flight_1.id}") do
        expect(page).to have_content("Flight Number: #{@flight_1.number}")
        expect(page).to have_content("Departure City: #{@flight_1.departure_city}")
        expect(page).to have_content("Arrival City: #{@flight_1.arrival_city}")
      end
      within("#flight-#{@flight_2.id}") do
        expect(page).to have_content("Flight Number: #{@flight_2.number}")
        expect(page).to have_content("Departure City: #{@flight_2.departure_city}")
        expect(page).to have_content("Arrival City: #{@flight_2.arrival_city}")
      end
      within("#flight-#{@flight_3.id}") do
        expect(page).to have_content("Flight Number: #{@flight_3.number}")
        expect(page).to have_content("Departure City: #{@flight_3.departure_city}")
        expect(page).to have_content("Arrival City: #{@flight_3.arrival_city}")
      end
    end
    it 'I see that flights are listed in alphabetical order by departure city (A - Z)' do
      expect(page).to have_content("Flight Number: #{@flight_1.number}")
      expect(page).to have_content("Flight Number: #{@flight_2.number}")
      expect(page).to have_content("Flight Number: #{@flight_3.number}")

      expect(@flight_3.departure_city).to appear_before(@flight_2.departure_city)
      expect(@flight_2.departure_city).to appear_before(@flight_1.departure_city)
    end
  end
end
