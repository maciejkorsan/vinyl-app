class LogsController < ApplicationController
  def create
    @log = Log.new
    @log.record_id = params[:record_id]
    @log.date = Date.today
    @log.save
    redirect_to records_path
  end

  def edit
    @log = Log.find(params[:id])
  end

  def update
    @log = Log.find(params[:id])
    @log.update(log_params)
    redirect_to history_path
  end

  def destroy
    @log = Log.find(params[:id])
    @log.destroy

    render turbo_stream: turbo_stream.remove(@log)
  end

  private

  def log_params
    params.require(:log).permit(:date, :record_id)
  end
end
