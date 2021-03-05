require 'rails_helper'

RSpec.describe 'As a visitor' do
  before :each do
    @flight_1 = Flight.create(number: 111, date: "01/01/01", time: "1:00pm", departure_city: "SLC", arrival_city: "Denver")
    @flight_2 = Flight.create(number: 222, date: "02/02/02", time: "2:00pm", departure_city: "LA", arrival_city: "Seattle")
    @flight_3 = Flight.create(number: 333, date: "03/03/03", time: "3:00pm", departure_city: "Dallas", arrival_city: "NYC")
    visit "/flights"
  end

  describe 'When I visit Flights Index page' do
    it 'I see each flight in the system including its number, departure city, and arrival city' do
      within("#flight-#{@flight_1.id}") do
        expect(page).to have_content(@flight_1.number)
        expect(page).to have_content(@flight_1.departure_city)
        expect(page).to have_content(@flight_1.arrival_city)
      end
      within("#flight-#{@flight_2.id}") do
        expect(page).to have_content(@flight_2.number)
        expect(page).to have_content(@flight_2.departure_city)
        expect(page).to have_content(@flight_2.arrival_city)
      end
      within("#flight-#{@flight_3.id}") do
        expect(page).to have_content(@flight_3.number)
        expect(page).to have_content(@flight_3.departure_city)
        expect(page).to have_content(@flight_3.arrival_city)
      end 
    end
  end
end
