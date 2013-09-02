require 'station'

describe Station do 
  let(:station0) { Station.new(20, 'City Road') }
  let(:station1) { Station.new(15, 'Old Street') }

  it 'has a capacity' do
    expect(station0.capacity).to eq 20 
    expect(station1.capacity).to eq 15
  end
  it 'has a location' do
    expect(station0.location).to eq 'City Road'
    expect(station1.location).to eq 'Old Street'
  end
end