class JourneysController < ApplicationController
  def create
    @journey = Journey.new(journey_params)
    @journey.user = current_user
    @journey.save
  end

  def show
  end
end
