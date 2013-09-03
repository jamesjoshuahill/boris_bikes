require_relative 'bike'

class Station
  attr_reader :capacity, :location

  def initialize(capacity, location)
    @capacity, @location = capacity, location
    @current_bikes = { :working => [], :broken => [] }
  end

  def put_back_working(bike)
    @current_bikes[:working] << bike if has_a_space?
  end

  def put_back_broken(bike, garage)
    if has_a_space?
      @current_bikes[:broken] << bike
      garage.receive_broken_bike_report(bike.id, location)
    end
  end

  def spaces
    @capacity - @current_bikes[:working].count - @current_bikes[:broken].count
  end
  
  def has_a_space?
    spaces > 0
  end

  def list_of_bike_ids
    #@current_bikes.map { |bike, status| bike.id }
    list_working = @current_bikes[:working].map {|bike| bike.id}
    list_broken = @current_bikes[:broken].map {|bike| bike.id}
    list = list_working.concat(list_broken)
  end

  def broken_bikes
    @current_bikes[:broken]
  end

  def working_bikes
    @current_bikes[:working]
  end

  def hire_a_bike
    working_bikes.pop if has_a_working_bike?
  end

  def has_a_working_bike?
    not working_bikes.empty?
  end

  def has_a_broken_bike?
    not broken_bikes.empty?
  end

  def collect_broken(bike_id)
    @current_bikes[:broken].find { |bike| bike.id == bike_id }
  end

end