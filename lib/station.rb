class Station
  attr_reader :capacity, :location 

  def initialize(capacity, location)
    @capacity, @location = capacity, location
  end
end