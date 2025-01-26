class HistoryController < ApplicationController
  def index
    @logs = Log.all.order(date: :desc, created_at: :desc)
  end
end
