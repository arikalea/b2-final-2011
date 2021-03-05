require "rails_helper"

describe Flight do
  before :each do
    @flight_1 = Flight.create(number: 111, date: "01/01/01", time: "1:00pm", departure_city: "SLC", arrival_city: "Denver")
    @flight_2 = Flight.create(number: 222, date: "02/02/02", time: "2:00pm", departure_city: "LA", arrival_city: "Seattle")
    @flight_3 = Flight.create(number: 333, date: "03/03/03", time: "3:00pm", departure_city: "Dallas", arrival_city: "NYC")
    @passenger_1 = @flight_1.passengers.create!(name: "Bob", age: 20)
    @passenger_2 = @flight_1.passengers.create!(name: "Sally", age: 17)
    @passenger_3 = @flight_1.passengers.create!(name: "Kim", age: 40)
    @passenger_4 = @flight_1.passengers.create!(name: "Rae", age: 30)
    @passenger_5 = @flight_1.passengers.create!(name: "Rae", age: 44)
  end

  describe "relationships" do
    it { should have_many :flight_passengers }
    it { should have_many(:passengers).through(:flight_passengers) }
  end

  describe 'class methods' do
    it '.sort_by_departure_city' do
      expected = [@flight_3, @flight_2, @flight_1]

      expect(Flight.sort_by_departure_city).to eq(expected)
    end
  end

  describe 'instance methods' do
    it '#adult_passengers' do
      expected = [@passenger_1, @passenger_3, @passenger_4, @passenger_5]

      expect(@flight_1.adult_passengers).to eq(expected)
      expect(@flight_1.adult_passengers).to_not eq(@passenger_2)
    end
    it '#avg_adult_age' do
      expect(@flight_1.avg_adult_age).to eq(33.5)
    end
  end
end
