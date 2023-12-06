class VisitsController < ApplicationController
  def create
    @visit = Visit.new
    @visit.journey = Journey.find(params[:journey_id])
    @visit.place = Place.find(params[:place_id])
    @visit.save

    redirect_to journey_places_path(@visit.journey, category_ids: params[:category_ids], weather_icon: params[:weather_icon])
  end

  def show
    @journey = Journey.find(params[:journey_id])
    @visit = @journey.visits.find(params[:id])
  end

  def destroy
    @visit = Visit.find(params[:id])
    @visit.destroy
    redirect_to journey_places_path(@visit.journey, category_ids: params[:category_ids], weather_icon: params[:weather_icon])
  end
end
