class JourneysController < ApplicationController
  def create
    @journey = Journey.new(journey_params)
    @journey.user = current_user
    @journey.save

  end

  def show
    @journey = Journey.find(params[:id])
    @places  = @journey.places
    @total_places_duration = @places.sum(:visit_duration)
  end

  def localize
    puts params
  end
end
