class VotesController < ApplicationController
  def update
    @location = Location.find(params[:location_id])
    @vote = Vote.find(params[:id])

    if @vote.update(vote_params)
      cookies[:posted] = { :value => true, :expires => 1.year.from_now }
      redirect_to @location, notice: 'Thank-you for voting!'
    else
      redirect_to @location, error: 'There was an error saving your vote. Contact EVfeedback@boston.gov if it continues.'
    end
  end

  def show
    @location = Location.find(params[:location_id])
    @vote = Vote.find(params[:id])
    @has_posted = cookies[:posted] || false
  end

  private

  def vote_params
    params.require(:vote).permit(:day, :time, :comment)
  end
end
