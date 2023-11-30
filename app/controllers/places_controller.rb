class PlacesController < ApplicationController
  def index
    @places = if params[:place] && params[:place][:name].present?
                Place.where("name LIKE ?", "%#{params[:place][:name]}%")
              else
                Place.all
              end

    @places = @places.first(10)

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
  end
end
