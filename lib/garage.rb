class Garage
  attr_reader :broken_bike_reports, :broken_bikes, :repaired_bikes

  def initialize(van)
    @van = van
    @broken_bike_reports = [] 
    @broken_bikes = []
    @repaired_bikes = []
  end 

  def receive_broken_bike_report(bike_id, station)
    @broken_bike_reports << [bike_id, station]
  end

  def send_orders_to_van
    @broken_bike_reports.each do |report|
      @van.add_order(report[0], report[1])
    end
    @broken_bike_reports = []
  end

  def receive_broken(bikes)
    @broken_bikes.concat bikes
  end

  def fix_broken_bikes
    @repaired_bikes.concat @broken_bikes
    @broken_bikes = []
  end

  def put_repaired_bikes_on_van
    @van.collect_repaired(@repaired_bikes)
    @repaired_bikes = []
  end


end