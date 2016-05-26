class DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV["USERNAME"], password: ENV["PASSWORD"]

  def index
    @locations = Location.all.order('votes_count DESC')
  end
end
