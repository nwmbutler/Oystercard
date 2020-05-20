class Oystercard
  attr_reader :balance, :entry_station

  MAX_BALANCE = 90
  DEFAULT_BALANCE = 0
  MIN_BALANCE = 1
  MIN_FARE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(value)
   fail "reached max limit" if exceed_max_balance(value)
   @balance += value
  end

  def exceed_max_balance(value)
    value + balance > MAX_BALANCE
  end

  def touch_in(entry_station)
    fail "insufficient funds" unless sufficient_funds?

    @in_journey = true
    @entry_station = entry_station
  end

  def touch_out
    deduct(MIN_FARE)
    @entry_station = nil
    @in_journey = false
  end

  def in_journey?
    !!@in_journey
  end

  def sufficient_funds?
    @balance > MIN_BALANCE
  end

private

  def deduct(value)
    @balance -= value
  end
end
