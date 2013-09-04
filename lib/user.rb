require_relative 'bike'
require_relative 'station'

class User
  attr_reader :name

  def initialize(name)
    @name = name
    @riding_a_bike = false
  end

  def hire_a_bike_from(station)
    @riding_a_bike = true if station.has_a_working_bike?
  end

  def riding_a_bike?
    @riding_a_bike
  end

end