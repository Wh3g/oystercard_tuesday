class OysterCard 
  attr_reader :balance
  BALANCE_LIMIT = 90
  BALANCE_MINIMUM = 1
  
  def initialize
    @balance = 0
    @travelling = false
  end

  def top_up(amount)
    fail "Limit of £#{BALANCE_LIMIT} is exceeded" if over_limit?(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @travelling
  end

  def touch_in
    fail "Insufficient funds." if insufficient_funds
    @travelling = true
  end

  def touch_out
    @travelling = false
  end

  private
  def over_limit?(amount)
    (@balance + amount) > BALANCE_LIMIT
  end
  
  def insufficient_funds
    @balance < BALANCE_MINIMUM
  end
end
