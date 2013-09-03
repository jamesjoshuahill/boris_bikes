require_relative 'bike'

class Station
  attr_reader :capacity, :location, :current_bikes

  def initialize(capacity, location)
    @capacity, @location = capacity, location
    @current_bikes = {}
  end

  def put_back(bike)
    @current_bikes[bike] = 'working' if has_a_space?
  end

  def put_back_broken(bike)
    @current_bikes[bike] = 'broken' if has_a_space?
  end
  
  def has_a_space?
    spaces > 0
  end

  def spaces
    @capacity - @current_bikes.length
  end

  def list_of_bikes
    @current_bikes.map { |bike, status| bike.serial_number }
  end

  def broken_bikes
    @current_bikes.select { |bike, status| status == 'broken' }
  end

end