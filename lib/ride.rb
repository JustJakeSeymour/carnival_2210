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

  def board_rider(visitor)
    total_revenue + @admission_fee
    visitor.spending_money - @admission_fee
    @rider_log[visitor] = (@rider_log[visitor].to_i + 1)
  end

end
