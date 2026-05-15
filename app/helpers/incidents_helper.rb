module IncidentsHelper
  def local_time(datetime)
    datetime.strftime("%Y年%m月%d日%H時%S秒")
  end
end
