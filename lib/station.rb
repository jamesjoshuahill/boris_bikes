class Station

  attr_reader :capacity, :location

  def initialize(capacity, location, garage)
    @capacity, @location, @garage = capacity, location, garage
    @current_bikes = { :working => [], :broken => [] }
  end

  def all_bikes
    @current_bikes[:working] + @current_bikes[:broken]
  end

  def broken_bikes
    @current_bikes[:broken]
  end

  def working_bikes
    @current_bikes[:working]
  end

  def list_of_bike_ids
    all_bikes.map { |bike| bike.id }.sort
  end

  def spaces
    @capacity - all_bikes.count
  end
  
  def has_a_space?
    spaces > 0
  end

  def spaces_for_repaired_bikes
    spaces_to_keep_open = (@capacity * 0.3).ceil
    spaces_to_fill = spaces - spaces_to_keep_open
    return spaces_to_fill if spaces_to_fill > 0
    return 0
  end

  def has_space_for_repaired_bikes?
    spaces_for_repaired_bikes > 0
  end

  def has_a_working_bike?
    not working_bikes.empty?
  end

  def has_a_broken_bike?
    not broken_bikes.empty?
  end

  def put_back_working(bike)
    working_bikes << bike if has_a_space?
  end

  def put_back_broken(bike)
    if has_a_space?
      broken_bikes << bike
      @garage.receive_broken_bike_report(bike.id, self)
    end
  end

  def hire_a_bike
    working_bikes.pop if has_a_working_bike?
  end

  def collect_broken(bike_id)
    broken_bikes.find { |bike| bike.id == bike_id }
  end

end
