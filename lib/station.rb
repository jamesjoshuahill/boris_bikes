require_relative 'bike'

class Station
  attr_reader :capacity, :location, :current_bikes

  def initialize(capacity, location)
    @capacity, @location = capacity, location
    @current_bikes = {}
  end

  def put_back_working(bike)
    @current_bikes[bike] = 'working' if has_a_space?
  end

  def put_back_broken(bike, garage)
    if has_a_space?
      @current_bikes[bike] = 'broken'
      garage.receive_broken_bike_report(bike, self)
    end
  end

  def spaces
    @capacity - @current_bikes.length
  end
  
  def has_a_space?
    spaces > 0
  end

  def list_of_bike_ids
    @current_bikes.map { |bike, status| bike.id }
  end

  def broken_bikes
    @current_bikes.select { |bike, status| status == 'broken' }.keys
  end

  def working_bikes
    @current_bikes.select { |bike, status| status == 'working' }.keys
  end

  def hire_a_bike
    if has_a_working_bike?
      bike = working_bikes.pop
      @current_bikes.delete(bike)
      return bike
    end
  end

  def has_a_working_bike?
    not working_bikes.empty?
  end

  def has_a_broken_bike?
    not broken_bikes.empty?
  end

  def collect_broken(bike_id)
    @current_bikes.select { |bike, status| bike.id == bike_id }.keys.first
  end

end