require 'station'

describe Station do 
  let(:station0) { Station.new(20, 'City Road') }
  let(:station1) { Station.new(15, 'Old Street') }
  let(:small_station) { Station.new(1, 'Small station') }
  let(:bike1) { double Bike, id: '1001' }
  let(:bike2) { double Bike, id: '1002' }
  let(:garage) { double :Garage, receive_broken_bike_report: nil }

  context 'should have a' do
    it 'capacity' do
      expect(station0.capacity).to eq 20 
      expect(station1.capacity).to eq 15
    end
    
    it 'location' do
      expect(station0.location).to eq 'City Road'
      expect(station1.location).to eq 'Old Street'
    end
  end

  context 'has docks and should know' do 
    it 'if there is space for a bike' do
      expect(station0.has_a_space?).to be_true
    end

    it 'if there is no space for a bike' do
      small_station.put_back_working(bike1)

      expect(small_station.has_a_space?).to be_false
    end

    it 'how many spaces are available' do
      expect(station0.spaces).to eq 20
      expect(station1.spaces).to eq 15

      station0.put_back_working(bike1)
      expect(station0.spaces).to eq 19
    end
  end

  context 'should know about docked bikes and' do
    it 'list all their ids' do
      station0.put_back_working(bike1)
      station0.put_back_working(bike2)

      expect(station0.list_of_bike_ids).to eq ['1001', '1002']
    end

    context 'know if there are' do
      it 'any working bikes' do
        station0.put_back_working(bike1)
        
        expect(station0.has_a_working_bike?).to be_true
      end

      it 'no working bikes' do
        expect(station0.has_a_working_bike?).to be_false
      end

      it 'any broken bikes' do
        station1.put_back_broken(bike1, garage)

        expect(station1.has_a_broken_bike?).to be_true
      end

      it 'no broken bikes' do
        expect(station1.has_a_broken_bike?).to be_false
      end
    end
  end

  context 'should for a working bike' do
    it 'put it back if there is a space' do
      station0.put_back_working(bike1)

      expect(station0.current_bikes).to include bike1
    end

    it 'not put it back if there is no space' do
      small_station.put_back_working(bike1)
      small_station.put_back_working(bike2)

      expect(small_station.current_bikes).not_to include bike2
    end

    it 'allow it to be hired if one is parked' do
      station0.put_back_working(bike1)

      expect(station0.hire_a_bike).to eq bike1
    end

    it 'not allow it to be hired if none is parked' do
      expect(station0.hire_a_bike).to eq nil

      station0.put_back_working(bike1)
      station0.hire_a_bike

      expect(station0.hire_a_bike).to eq nil
    end
  end

  context 'should for a broken bike' do
    it 'put it back if there is a space and report it to the Garage' do
      garage.should_receive(:receive_broken_bike_report).with bike1, station0
      station0.put_back_broken(bike1, garage)

      expect(station0.broken_bikes).to include bike1
    end

    it 'not put it back if there is no space' do
      small_station.put_back_broken(bike1, garage)
      small_station.put_back_broken(bike2, garage)

      expect(small_station.current_bikes).not_to include bike2
    end

    it 'allow a broken bike to be collected by a van' do
      station1.put_back_broken(bike1, garage)

      expect(station1.collect_broken(bike1.id)).to eq bike1
    end
  end

end