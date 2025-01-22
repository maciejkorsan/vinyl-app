class HistoryController < ApplicationController
  def index
    @logs = Log.all.order(date: :desc)
  end
end
