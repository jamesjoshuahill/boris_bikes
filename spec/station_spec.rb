require 'station'

describe Station do 
  let(:station) { Station.new(20, 'City Road') }
  let(:small_station) { Station.new(1, 'Small station') }
  let(:bike1) { double Bike, id: '1001' }
  let(:bike2) { double Bike, id: '1002' }
  let(:garage) { double :Garage, receive_broken_bike_report: nil }

  context 'should have a' do
    it 'capacity' do
      expect(station.capacity).to eq 20 
      expect(small_station.capacity).to eq 1
    end
    
    it 'location' do
      expect(station.location).to eq 'City Road'
      expect(small_station.location).to eq 'Small station'
    end
  end

  context 'has docks and should know' do 
    it 'if there is space for a bike' do
      #expect(station.has_a_space?).to be_true
      expect(station).to have_a_space
    end

    it 'if there is no space for a bike' do
      small_station.put_back_working(bike1)

      # expect(small_station.has_a_space?).to be_false
      expect(small_station).not_to have_a_space
    end

    it 'how many spaces are available' do
      expect(station.spaces).to eq 20
      expect(small_station.spaces).to eq 1

      station.put_back_working(bike1)
      expect(station.spaces).to eq 19
    end
  end

  context 'should know about docked bikes and' do
    it 'list all their ids' do
      station.put_back_working(bike1)
      station.put_back_working(bike2)

      expect(station.list_of_bike_ids).to eq ['1001', '1002']
    end

    context 'know if there are' do
      it 'any working bikes' do
        station.put_back_working(bike1)
        
        # expect(station.has_a_working_bike?).to be_true
        expect(station).to have_a_working_bike
      end

      it 'no working bikes' do
        # expect(station.has_a_working_bike?).to be_false
        expect(station).not_to have_a_working_bike
      end

      it 'any broken bikes' do
        station.put_back_broken(bike1, garage)

        # expect(station.has_a_broken_bike?).to be_true
        expect(station).to have_a_broken_bike
      end

      it 'no broken bikes' do
        # expect(station.has_a_broken_bike?).to be_false
        expect(station).not_to have_a_broken_bike
      end
    end
  end

  context 'if there is a space, should put back' do
    it 'a working bike' do
      station.put_back_working(bike1)

      expect(station.current_bikes).to include bike1
    end

    it 'a broken bike and report it to the Garage' do
      garage.should_receive(:receive_broken_bike_report).with bike1, station
      station.put_back_broken(bike1, garage)

      expect(station.broken_bikes).to include bike1
    end
  end

  context 'if there is no space, should not put back' do
    it 'a working bike' do
      small_station.put_back_working(bike1)
      small_station.put_back_working(bike2)

      expect(small_station.current_bikes).not_to include bike2
    end

    it 'a broken bike' do
      small_station.put_back_broken(bike1, garage)
      small_station.put_back_broken(bike2, garage)

      expect(small_station.current_bikes).not_to include bike2
    end
  end

  context 'release working bikes to hire' do
    it 'if one is parked' do
      station.put_back_working(bike1)

      expect(station.hire_a_bike).to eq bike1
    end

    it 'but not if there are no bikes parked' do
      expect(station.hire_a_bike).to eq nil

      station.put_back_working(bike1)
      station.hire_a_bike

      expect(station.hire_a_bike).to eq nil
    end

    it 'but not if there are only broken bikes' do
      station.put_back_broken(bike1, garage)

      expect(station.hire_a_bike).to eq nil
    end
  end

  context 'release broken bikes' do
    it 'when a van requests a broken bike' do
      station.put_back_broken(bike1, garage)

      expect(station.collect_broken(bike1.id)).to eq bike1
    end
  end

end