require "rails_helper"

describe Flight do
  describe "relationships" do
    it { should have_many :flight_passengers }
    it { should have_many(:passengers).through(:flight_passengers) }
  end
end
