class JourneysController < ApplicationController
  def create
    @duration = (params[:duration_hours].to_i * 60) + params[:duration_minutes].to_i
    @journey = Journey.new(duration: @duration)
    @journey.user = current_user
    @journey.save

    redirect_to journey_places_path(@journey, category_ids: params[:category_ids])
  end

  def show
    @journey = Journey.find(params[:id])
    @places = @journey.places
    @categories = Category.all
    @total_places_duration = @places.sum(:visit_duration)
  end

  def localize
    puts params
  end
end
