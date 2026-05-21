module IncidentTimesHelper
  def yeardeco(time)
    if time.year.nil?
      ""
    else
      "#{time.year}年"
    end
  end
  def monthdeco(time)
    if time.month.nil?
      ""
    else
      "#{time.month}月"
    end
  end
  def datedeco(time)
    if time.date.nil?
      ""
    else
      "#{time.date}日"
    end
  end
  def hourdeco(time)
    return "" if time.hour.nil?
    if time.minute.nil? || time.second.nil?
      "#{time.hour}時頃"
    else
      "#{time.hour}時"
    end
  end
  def minutedeco(time)
    if time.minute.nil?
      ""
    else
      "#{time.minute}分"
    end
  end
  def seconddeco(time)
    if time.second.nil?
      ""
    else
      "#{time.second}秒"
    end
  end
end
