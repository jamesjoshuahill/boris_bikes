class Van
  attr_reader :garage, :orders
  attr_accessor :bikes

  def initialize(garage)
    @garage = garage
    @orders = []
    @bikes = []
  end

  def add_order(bike_id, station)
    @orders << [bike_id, station]
  end

  def collect_broken_bike(bike_id, station)
    @bikes << station.collect_broken(bike_id)
  end

  def deliver_broken_bikes
    garage.deliver_broken_bikes(@bikes)
    @bikes = []
  end

  def fulfill_orders
    @orders.each do |order|
      collect_broken_bike(order[0], order[1])
    end
    @orders = []
    deliver_broken_bikes
  end

end