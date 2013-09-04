require 'user'

describe User do
  let(:boris) { User.new('Boris') }

  it 'should have a name' do
    expect(boris.name).to eq 'Boris'
    yuin = User.new('Yuin')
    expect(yuin.name).to eq 'Yuin'
  end

  it 'should hire a bike from a station with a working bike' do
    station = double Station
    station.should_receive(:has_a_working_bike?).and_return true
    boris.hire_a_bike_from(station)

    expect(boris).to be_riding_a_bike
  end

  it 'should not hire a bike from a station with no working bikes' do
    station = double Station
    station.should_receive(:has_a_working_bike?).and_return false
    boris.hire_a_bike_from(station)

    expect(boris).not_to be_riding_a_bike
  end

end