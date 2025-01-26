class DashboardController < ApplicationController
  def index
    @records_count = Record.all.count
    @artists_count = Artist.all.count
    @logs_count = Log.all.count
    @last_played = Log.order(date: :desc, created_at: :desc).first
    @total_time_listened = Log.joins(:record).sum(:running_time)
  end
end
