require 'station'

describe Station do 
  let(:station0) { Station.new(20, 'City Road') }
  let(:station1) { Station.new(15, 'Old Street') }
  let(:small_station) { Station.new(1, 'Small station') }
  let(:bike1) { double Bike }
  let(:garage) { double :Garage }

  it 'has a capacity' do
    expect(station0.capacity).to eq 20 
    expect(station1.capacity).to eq 15
  end
  
  it 'has a location' do
    expect(station0.location).to eq 'City Road'
    expect(station1.location).to eq 'Old Street'
  end

  it 'should put back a bike if there is a space' do
    station0.put_back(bike1)
    expect(station0.current_bikes).to include bike1
  end

  it 'should not put back a bike if there is no space' do
    small_station.put_back(bike1)
    bike2 = double Bike
    small_station.put_back(bike2)
    expect(small_station.current_bikes).not_to include bike2
  end

  it 'should know if there is space for a bike' do
    expect(station0.has_a_space?).to be_true
  end

  it 'should know if there is no space for a bike' do
    small_station.put_back(bike1)
    expect(small_station.has_a_space?).to be_false
  end

  it 'should know how many spaces are available' do
    expect(station0.spaces).to eq 20
    expect(station1.spaces).to eq 15
    station0.put_back(bike1)
    expect(station0.spaces).to eq 19
  end

  it 'should list all the bike ids at the station' do
    bike3 = double Bike, id: '1003'
    bike4 = double Bike, id: '1004'
    station0.put_back(bike3)
    station0.put_back(bike4)
    expect(station0.list_of_bike_ids).to eq ['1003', '1004']
  end

  it 'should mark a bike as broken and report it to Garage' do
    garage.should_receive(:receive_broken_bike_report).with bike1, station0
    station0.put_back_broken(bike1, garage)
    expect(station0.broken_bikes).to include bike1
  end

end