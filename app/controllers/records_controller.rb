class RecordsController < ApplicationController
  def index
    @records = Record.all
  end

  def create
    @record = Record.new(record_params)
    @record.save
    redirect_to records_path
  end

  def new
    @record = Record.new
  end

  def show
    @record = Record.find(params[:id])
  end

  def edit
    @record = Record.find(params[:id])
  end

  def update
    @record = Record.find(params[:id])
    @record.update(record_params)
    redirect_to records_path
  end

  private

  def record_params
    params.require(:record).permit(:title, :artist_id, :cover)
  end
end
