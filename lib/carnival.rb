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

  def unique_visitors
    visitors = []
    rides.each do |ride|
      visitors << ride.rider_log.keys
    end
    visitors.uniq
  end

  def visitor_count
    unique_visitors.length
  end

  def ride_analysis
    analysis = {}
    @rides.each do |ride|
      analysis[ride] = [ride.rider_log.keys[0], ride.total_revenue]  
    end
    analysis
  end

  def summary
    {
      visitor_count: visitor_count,
      total_revenue: total_revenue,
      visitor_analysis: visitor_analysis,
      ride_analysis: ride_analysis
    }
  end
end