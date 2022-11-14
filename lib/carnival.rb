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
end