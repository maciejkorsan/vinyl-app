class LogsController < ApplicationController
  def create
    @log = Log.new
    @log.record_id = params[:record_id]
    @log.date = Date.today
    @log.save

    @record = Record.find(params[:record_id])

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to logs_path }
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

    redirect_to logs_path
  end

  def destroy
    @log = Log.find(params[:id])
    @log.destroy
  end

  private

  def log_params
    params.require(:log).permit(:date, :record_id)
  end
end
