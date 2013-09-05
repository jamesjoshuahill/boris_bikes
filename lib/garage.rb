class Garage
  attr_reader :broken_bike_reports
  
  def initialize
    @broken_bike_reports = [] 
  end 

  def receive_broken_bike_report (bike_id, station)
    @broken_bike_reports << [bike_id, station]
  end

end