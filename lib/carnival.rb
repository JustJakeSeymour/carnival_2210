require 'date'

class Carnival
  attr_reader :rides

  def initialize(dates)
    @date_start = Date.parse(dates[0])
    @date_end = Date.parse(dates[1])
    @rides = []
  end
  
  def duration
    (@date_end - @date_start).to_i
  end

  def add_ride(ride)
    @rides << ride
  end

  def most_popular_ride
    rides.max_by{|ride| ride.rider_log.values.sum}
  end

  def most_profitable_ride
    rides.max_by{|ride| ride.total_revenue}
  end

  def total_revenue
    rides.sum{|ride| ride.total_revenue}
  end
  
end