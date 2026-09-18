module IncidentTimesHelper
  def display_incident_time(time)
    parts = []

    parts << "#{time.year}年" if time.year.present?
    parts << "#{time.month}月" if time.month.present?
    parts << "#{time.date}日" if time.date.present?
    parts << "#{time.hour}時" if time.hour.present?
    parts << "#{time.minute}分" if time.minute.present?
    parts << "#{time.second}秒" if time.second.present?

    parts.join
  end
end
