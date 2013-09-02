require_relative 'bike'

class Station
  attr_reader :capacity, :location, :current_bikes

  def initialize(capacity, location)
    @capacity, @location = capacity, location
    @current_bikes = []
  end

  def put_back(bike)
    @current_bikes << bike if has_a_space?
  end

  def has_a_space?
    @current_bikes.length < capacity
  end

end