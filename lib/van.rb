class Van

  attr_reader :garage, :orders, :broken_bikes, :repaired_bikes

  def initialize(garage)
    @garage = garage
    @orders = []
    @broken_bikes = []
    @repaired_bikes = []
  end

  def add_order(bike_id, station)
    @orders << [bike_id, station]
  end

  def collect_broken_bike(bike_id, station)
    @broken_bikes << station.collect_broken(bike_id)
    put_back_repaired_bikes(station) if has_repaired_bikes?
  end

  def has_repaired_bikes?
    not @repaired_bikes.empty?
  end

  def put_back_repaired_bikes(station)
    if station.has_space_for_repaired_bikes?
      station.spaces_for_repaired_bikes.times do
        station.put_back_working(@repaired_bikes.pop)
        break if @repaired_bikes.count == 0
      end
    end
  end

  def deliver_broken_bikes
    garage.receive_broken_bikes(@broken_bikes)
    @broken_bikes = []
  end

  def fulfill_orders
    @orders.each do |order|
      collect_broken_bike(order[0], order[1])
    end
    @orders = []
    deliver_broken_bikes
  end

  def collect_repaired(bikes)
    @repaired_bikes.concat bikes
  end

end
