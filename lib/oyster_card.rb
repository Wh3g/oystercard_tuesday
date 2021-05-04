class OysterCard 
  attr_reader :balance
  BALANCE_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Limit of £#{BALANCE_LIMIT} is exceeded" if over_limit?(amount)
    @balance += amount
  end

  private
  def over_limit?(amount)
    (@balance + amount) > BALANCE_LIMIT
  end
end