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
    @admission_fee * rider_log.values.sum
  end

  def board_rider(visitor)
    return nil if !can_ride?(visitor)
    take_admission(visitor)
    @rider_log[visitor] = (@rider_log[visitor].to_i + 1)
  end

  def can_ride?(visitor)
    visitor.height > @min_height && visitor.preferences.any?{|preference| preference == @excitement}
  end

  def take_admission(visitor)
    visitor.update_spending_money(@admission_fee)
  end
end
