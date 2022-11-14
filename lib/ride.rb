class Ride
  attr_reader :name,
  :min_height,
  :admission_fee,
  :excitement,
  :rider_log

  def initialize(hash)
    @name = hash[:name]
    @min_height = hash[:min_height]
    @admission_fee = hash[:admission_fee]
    @excitement = hash[:excitement]
    @rider_log = {}
  end

  def total_revenue
    0
  end

end
