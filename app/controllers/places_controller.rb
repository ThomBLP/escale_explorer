class PlacesController < ApplicationController
  def index
    @places = if params[:place] && params[:place][:name].present?
                Place.where("name LIKE ?", "%#{params[:place][:name]}%")
              else
                Place.all
              end

    @places_durations = @places.map do |place|
      {
        place.id => MapboxServices.new.get_duration([45.76948487018482, 4.834866446452691], [place.lat, place.long])
      }
    end
  end

  def show
  end
end
