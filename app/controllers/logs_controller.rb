class LogsController < ApplicationController
  def create
    @log = Log.new
    @log.record_id = params[:record_id]
    @log.date = Date.today
    @log.save
    redirect_to records_path
  end

  def destroy
    @log = Log.find(params[:id])
    @log.destroy
    redirect_to history_path
  end
end
