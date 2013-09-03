require_relative 'bike'
require_relative 'garage'

class Station
  attr_reader :capacity, :location, :current_bikes

  def initialize(capacity, location)
    @capacity, @location = capacity, location
    @current_bikes = {}
  end

  def put_back(bike)
    @current_bikes[bike] = 'working' if has_a_space?
  end

  def put_back_broken(bike, garage)
    if has_a_space?
      @current_bikes[bike] = 'broken'
      garage.receive_broken_bike_report(bike, self)
    end
  end
  
  def has_a_space?
    spaces > 0
  end

  def spaces
    @capacity - @current_bikes.length
  end

  def list_of_bike_ids
    @current_bikes.map { |bike, status| bike.id }
  end

  def broken_bikes
    @current_bikes.select { |bike, status| status == 'broken' }
  end

end