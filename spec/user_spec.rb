require 'user'

describe User do
  
  it 'should have a name' do
    boris = User.new('Boris')  
    expect(boris.name).to eq 'Boris'
    yuin = User.new('Yuin')
    expect(yuin.name).to eq 'Yuin'
  end

  it 'should hire a bike from a station' do
    boris = User.new('Boris')
    station = double Station
    #station.should_receive(:has_a_working_bike?)
    boris.hire_a_bike_from(station)

    expect(boris).to be_riding_a_bike
  end

end