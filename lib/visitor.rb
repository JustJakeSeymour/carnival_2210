class Visitor
  attr_reader :name,
              :height,
              :spending_money,
              :preferences

  def initialize(name, height, spending_money)
    @name = name
    @height = height
    @spending_money = spending_money.tr("$","").to_i
    @preferences = []
  end

  def update_spending_money(admission)
    @spending_money -= admission
    money_spent += admission
  end

  def money_spent
    0
  end

  def add_preference(preference)
    @preferences << preference
  end
  
  def tall_enough?(height)
    @height >= height
  end
end
