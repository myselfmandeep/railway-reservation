module DateAndTimeHelper

  def format_date(date)
    date.strftime("%d/%m/%Y %I:%M %p")
  end
  
  def format_time(date, time)
    date_time = "#{date} #{time}"
    Time.parse(time).strftime("%d/%m/%Y %I:%M %p")
  end
  
end