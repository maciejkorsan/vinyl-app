module DashboardHelper
  def format_time(time)
    days = time / 86400
    hours = (time % 86400) / 3600
    minutes = (time % 3600) / 60
    "#{days} day#{days > 1 || days == 0 ? "s" : ""} #{hours} hour#{hours > 1 || hours == 0 ? "s" : ""} #{minutes} minute#{minutes > 1 || minutes == 0 ? "s" : ""}  "
  end
end
