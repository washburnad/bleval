module Timing
  # cancels (assigns status 6) to all tasks in array
  def self.in_one_day
    Time.now + 1.day
  end
end