require 'garage'

# should receive broken bike reports
# should send orders to vans
# 

describe Garage do
  
  it 'should receive broken bike reports from stations' do
    garage = Garage.new
    station = double :Station
    garage.receive_broken_bike_report('1001', station)
    garage.receive_broken_bike_report('1099', station)
    expect(garage.broken_bike_reports).to include ['1001', station]
    expect(garage.broken_bike_reports).to include ['1099', station]
  end

end