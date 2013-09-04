require 'user'

describe User do
  let(:boris) { User.new('Boris') }
  let(:station) { double :Station }
  let(:bike) { double :Bike }

  it 'should have a name' do
    expect(boris.name).to eq 'Boris'
    yuin = User.new('Yuin')
    expect(yuin.name).to eq 'Yuin'
  end

  it 'should hire a bike from a station with a working bike' do
    station.should_receive(:has_a_working_bike?).and_return true
    station.should_receive(:hire_a_bike).and_return bike
    
    boris.hire_a_bike_from(station)

    expect(boris).to be_riding_a_bike
    expect(boris.my_bike).to eq bike
  end

  it 'should not hire a bike from a station with no working bikes' do
    station.should_receive(:has_a_working_bike?).and_return false
    
    boris.hire_a_bike_from(station)

    expect(boris).not_to be_riding_a_bike
  end

  it 'should return a working bike if the station has a space' do 
    boris.my_bike = bike
    station.should_receive(:has_a_space?).and_return true
    station.should_receive(:put_back_working).with(bike)

    boris.return_working_bike_to(station)

    expect(boris).not_to be_riding_a_bike
  end

  it 'should not return a working bike if the station has no spaces' do
    boris.my_bike = bike
    station.should_receive(:has_a_space?).and_return false

    boris.return_working_bike_to(station)

    expect(boris).to be_riding_a_bike
  end

  it 'should return a broken bike if the station has a space' do
    boris.my_bike = bike
    station.should_receive(:has_a_space?).and_return true
    station.should_receive(:put_back_broken).with(bike)

    boris.return_broken_bike_to(station)

    expect(boris).not_to be_riding_a_bike
  end

  it 'should not return a broken bike if the station has no spaces' do
    boris.my_bike = bike
    station.should_receive(:has_a_space?).and_return false

    boris.return_broken_bike_to(station)

    expect(boris).to be_riding_a_bike
  end

end