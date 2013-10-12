require 'bike'

describe Bike do

  it 'has an id' do
    bike = Bike.new('00001')
    expect(bike.id).to eq '00001'

    bike = Bike.new('00002')
    expect(bike.id).to eq '00002'
  end

end
