require_relative 'bike'
require_relative 'station'

class User
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def hire_a_bike_from(station)
  end

  def riding_a_bike?
    true
  end

end