require 'van'

describe Van do
  let(:garage) { double :Garage }
  let(:van) { Van.new(garage) }
  let(:station) { double :Station }
  let(:bike1) { double :Bike, id: '1001' }
  let(:bike2) { double :Bike, id: '1002' }

  it 'should know the garage location' do
    expect(van.garage).to eq garage
  end

  it 'should receive an order from the garage' do
    van.add_order(bike1.id, station)

    expect(van.orders).to include [bike1.id, station]
  end

  it 'should collect a bike from a station' do
    station.should_receive(:collect_broken).with((bike1.id)).and_return bike1
    van.collect_broken_bike(bike1.id, station)

    expect(van.bikes).to include bike1
  end

  it 'should deliver bikes to the garage' do
    van.bikes = [bike1, bike2]
    garage.should_receive(:deliver_broken_bikes).with([bike1, bike2])
    van.deliver_broken_bikes

    expect(van.bikes).to be_empty
  end

  it 'should fulfill all its orders and deliver the broken bikes' do
    van.add_order(bike1.id, station)
    van.add_order(bike2.id, station)
    station.should_receive(:collect_broken).with(bike1.id).and_return bike1
    station.should_receive(:collect_broken).with(bike2.id).and_return bike2
    garage.should_receive(:deliver_broken_bikes).with([bike1, bike2])
    van.fulfill_orders

    expect(van.bikes).to be_empty
    expect(van.orders).to be_empty
  end

end