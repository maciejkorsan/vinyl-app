class LogsController < ApplicationController
  def create
    @log = Log.new
    @log.record_id = params[:record_id]
    @log.date = Date.today
    @log.save

    respond_to do |format|
      format.turbo_stream
    end
  end

  def edit
    @log = Log.find(params[:id])
  end

  def index
    @logs = Log.all.order(date: :desc, created_at: :desc)
  end

  def update
    @log = Log.find(params[:id])
    @log.update(log_params)
    respond_to do |format|
      format.html { redirect_to history_path }
      format.turbo_stream
    end
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
