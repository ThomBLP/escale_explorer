class PlacesController < ApplicationController
  def index
    @duration = params[:duration_hours].to_i * 60 + params[:duration_minutes].to_i
    @places = Place.where(category_id: params[:category_ids]).where("visit_duration < ?", @duration).first(5)

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
    @place = Place.find(params[:id])
  end
end
