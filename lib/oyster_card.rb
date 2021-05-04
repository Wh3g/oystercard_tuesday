class OysterCard 
  attr_reader :balance
  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @travelling = false
  end

  def top_up(amount)
    fail "Limit of £#{BALANCE_LIMIT} is exceeded" if over_limit?(amount)
    @balance += amount
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
    deduct(MINIMUM_FARE)
  end
  
  private
  def deduct(amount)
    @balance -= amount
  end

  def over_limit?(amount)
    (@balance + amount) > BALANCE_LIMIT
  end
  
  def insufficient_funds
    @balance < MINIMUM_FARE
  end
end
