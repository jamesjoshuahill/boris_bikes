class User
  attr_reader :name, :my_bike

  def initialize(name)
    @name, @my_bike = name, nil
  end

  def hire_a_bike_from(station)
    @my_bike = station.hire_a_bike if station.has_a_working_bike?
  end

  def riding_a_bike?
    @my_bike
  end

  def clear_my_bike
    @my_bike = nil
  end

  def return_working_bike_to(station)
    if station.has_a_space?
      station.put_back_working(@my_bike) 
      clear_my_bike
    end
  end

  def return_broken_bike_to(station)
    if station.has_a_space?
      station.put_back_broken(@my_bike)
      clear_my_bike
    end
  end

end