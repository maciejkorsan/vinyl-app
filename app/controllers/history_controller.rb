class HistoryController < ApplicationController
  def index
    @logs = Log.all
  end
end
