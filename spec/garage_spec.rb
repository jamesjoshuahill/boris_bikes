require 'garage'

describe Garage do
  let(:van) { double :Van }
  let(:garage) { Garage.new(van) }
  let(:station) { double :Station }
  let(:bike1) { double :Bike }
  let(:bike2) { double :Bike }
  
  it 'should receive broken bike reports from stations' do
    garage.receive_broken_bike_report('1001', station)
    garage.receive_broken_bike_report('1099', station)
    expect(garage.broken_bike_reports).to include ['1001', station]
    expect(garage.broken_bike_reports).to include ['1099', station]
  end

  it 'should send orders to the van' do
    garage.receive_broken_bike_report('1001', station)
    garage.receive_broken_bike_report('1099', station)
    van.should_receive(:add_order).with('1001', station)
    van.should_receive(:add_order).with('1099', station)
    garage.send_orders_to_van

    expect(garage.broken_bike_reports).to be_empty
  end

  it 'should receive deliveries of broken bikes from the van' do
    garage.receive_broken([bike1, bike2])

    expect(garage.broken_bikes).to match_array [bike1, bike2]
  end

  it 'should fix broken bikes' do
    garage.receive_broken([bike1, bike2])
    garage.fix_broken_bikes

    expect(garage.broken_bikes).to be_empty
    expect(garage.repaired_bikes).to match_array [bike1, bike2]
  end

  xit 'should allocate repaired bikes to stations' do

  end

end