class DashboardController < ApplicationController
  def index
    @records_count = Record.all.count
    @artists_count = Artist.all.count
    @logs_count = Log.all.count
    @last_played = Log.order(date: :desc, created_at: :desc).first
    @total_time_listened = Log.joins(:record).sum(:running_time)

    @artists = Artist.joins(:records).group(:name).order("count(records.id) desc").limit(5)
  end

  def log
    @last_played = Log.new
    @last_played.record_id = params[:record_id]
    @last_played.date = Date.today
    @last_played.save

    @logs_count = Log.all.count
    @total_time_listened = Log.joins(:record).sum(:running_time)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to logs_path }
    end
  end
end
