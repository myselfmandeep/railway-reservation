require "securerandom"

Object.class_eval do
  def get_random_number(n)
    begin
      SecureRandom.random_number(eval("1e#{n}")...eval("10e#{n}")).floor
    rescue => e 
      retry
    end
  end

  def today(upcomming_days=0)
    Date.today + upcomming_days.day
  end
  
end