require 'rails_helper'

RSpec.describe 'As a visitor' do
  before :each do
    @flight_1 = Flight.create(number: 111, date: "01/01/01", time: "1:00pm", departure_city: "SLC", arrival_city: "Denver")
    @passenger_1 = @flight_1.passengers.create!(name: "Bob", age: 20)
    @passenger_2 = @flight_1.passengers.create!(name: "Sally", age: 17)
    @passenger_3 = @flight_1.passengers.create!(name: "Kim", age: 40)
    @passenger_4 = @flight_1.passengers.create!(name: "Rae", age: 30)
    @passenger_5 = @flight_1.passengers.create!(name: "Rae", age: 44)
    # average age = 33.5
    visit "/flights/#{@flight_1.id}"
  end

  describe 'When I visit Flights Show page' do
    it 'Then I see the flights number, date, time, departure city, and arrival city
      And I see the names of all adult passengers on the flight' do
      expect(page).to have_content("Flight Number: #{@flight_1.number}")
      expect(page).to have_content("Date: #{@flight_1.date}")
      expect(page).to have_content("Time: #{@flight_1.time}")
      expect(page).to have_content("Departure City: #{@flight_1.departure_city}")
      expect(page).to have_content("Arrival City: #{@flight_1.arrival_city}")

      within(".adult-passengers") do
        expect(page).to have_content(@passenger_1.name)
        expect(page).to have_content(@passenger_3.name)
        expect(page).to have_content(@passenger_4.name)
        expect(page).to have_content(@passenger_5.name)
        expect(page).to_not have_content(@passenger_2.name)
      end
    end
    it 'I see the average age of all adult passengers on the flight' do
      expect(page).to have_content("Average age of adult passengers: #{@flight_1.avg_adult_age}")
    end
    it 'Next to each passengers name I see a link or button to remove that passenger from that flight
      When I click on that link or button
      Im returned to the flights show page
      And I no longer see that passenger listed' do
      within("#adult-passenger-#{@passenger_1.id}") do
        expect(page).to have_button("Remove Passenger from flight")

        click_on"Remove Passenger from flight"
      end

      expect(current_path).to eq("/flights/#{@flight_1.id}")

      within(".adult-passengers") do
        expect(page).to_not have_content(@passenger_1.name)
      end 
    end
  end
end
