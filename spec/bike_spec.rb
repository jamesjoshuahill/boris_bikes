require 'bike'

describe Bike do
  it 'has a serial number' do
    bike = Bike.new('00001')
    expect(bike.serial_number).to eq '00001'
    bike = Bike.new('00002')
    expect(bike.serial_number).to eq '00002'
  end
end