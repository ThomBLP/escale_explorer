class PlacesController < ApplicationController
  def index
    @journey = Journey.find(params[:journey_id])
    @rest_time = @journey.duration - @journey.places.sum(:visit_duration)
    @places = Place.where.not(id: @journey.place_ids).where(category_id: params[:category_ids]).where("visit_duration <= ?", @rest_time).first(10)
    if params[:latitude] && params[:longitude]
      @latitude  = params[:latitude]
      @longitude = params[:longitude]
    end

    respond_to do |format|
      format.html
      format.text { render partial: "places/list", locals: { places: @places }, formats: [:html] }
    end
  end

  def show
    @journey = Journey.find(params[:journey_id])
    @place= Place.find(params[:id])
    @categories = Category.all

    # if @place
    #   redirect_to journey_place_path(@journey, category_ids: params[:category_ids])
    # else
    #   flash[:alert] = "Aucun lieu trouvé"
    # end
  end
end
