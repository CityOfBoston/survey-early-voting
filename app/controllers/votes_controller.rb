class VotesController < ApplicationController
  def create
    @location = Location.find(params[:location_id])

    @vote = @location.votes.build(vote_params)

    if @vote.save
      cookies[:posted] = { :value => true, :expires => 1.year.from_now }
      redirect_to @location, notice: 'Thank-you for voting!'
    else
      redirect_to @location, error: 'There was an error saving your vote. Contact digital@boston.gov if it continues.'
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:day, :time, :comment)
  end
end
