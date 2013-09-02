require 'station'

describe Station do 
  let(:station0) { Station.new(20, 'City Road') }
  let(:station1) { Station.new(15, 'Old Street') }
  let(:small_station) { Station.new(1, 'Small station') }
  let(:bike) { double Bike }

  it 'has a capacity' do
    expect(station0.capacity).to eq 20 
    expect(station1.capacity).to eq 15
  end
  
  it 'has a location' do
    expect(station0.location).to eq 'City Road'
    expect(station1.location).to eq 'Old Street'
  end

  it 'should put back a bike if there is a space' do
    station0.put_back(bike)
    expect(station0.current_bikes).to include bike
  end

  it 'should not put back a bike if there is no space' do
    small_station.put_back(bike)
    bike2 = double Bike
    small_station.put_back(bike2)
    expect(small_station.current_bikes).not_to include bike2
  end

  it 'should know if there is space for a bike' do
    expect(station0.has_a_space?).to be_true
  end

  it 'should know if there is no space for a bike' do
    small_station.put_back(bike)
    expect(small_station.has_a_space?).to be_false
  end
end