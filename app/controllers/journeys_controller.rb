class JourneysController < ApplicationController
  require 'open-uri'
  require 'json'

  def create
    @journey  = Journey.new(journey_params)
    hours     = params.dig(:journey, :duration_hours).split(":").first
    minutes   = params.dig(:journey, :duration_hours).split(":").last
    @duration = (hours.to_i * 60) + minutes.to_i
    @journey.duration = @duration
    @journey.user = current_user
    @journey.save

    redirect_to journey_places_path(@journey, category_ids: params[:category_ids], weather_icon: params[:weather_icon])
  end

  def show
    @journey = Journey.find(params[:id])
    @places = @journey.places
    @categories = Category.all
    @total_places_duration = @places.sum(:visit_duration)
    @weather_icon = params[:weather_icon]
    @travel_mode = params[:travel_mode]
    @coords = @places.pluck(:long, :lat)
  end

  def localize
    puts params
  end

  private

  def journey_params
    params.require(:journey).permit(:weather_icon, :travel_mode)
  end
end
