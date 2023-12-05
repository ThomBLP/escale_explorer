class PlacesController < ApplicationController
  def index
    @journey   = Journey.find(params[:journey_id])
    @rest_time = @journey.duration - @journey.places.sum(:visit_duration)
    @places    = Place.where.not(id: @journey.place_ids)

    p "************* PARAMS *************"
    p params
    p @journey

    if params[:keyword].present?
      @places = @places.where('name ILIKE ?', "%#{params[:keyword]}%")
    elsif params[:category_ids]
      @places = @places.where(category_id: params[:category_ids])
                      #  .where.not("weather_icons::text LIKE ?", "%#{@journey.weather_icon}%")
                       .where("visit_duration <= ?", @rest_time)
    end

    @places = @places.first(20)

    if params[:lat] && params[:long]
      @latitude  = params[:lat]
      @longitude = params[:long]
    end

    respond_to do |format|
      format.html
      format.text { render partial: "places/list", locals: { places: @places }, formats: [:html] }
    end
  end

  def show
    @journey = Journey.find(params[:journey_id])
    @place = Place.find(params[:id])
    @categories = Category.all
  end

  def nearby_restaurants
    @place = Place.find(params[:id])
    lat = @place.lat.to_f
    long = @place.long.to_f
    @nearby_restaurants = Place.joins(:category).near([lat, long], 0.2, units: :km).where(categories: { name: 'restaurants' })
  end

  def nearby_bars
    @place = Place.find(params[:id])
    lat = @place.lat.to_f
    long = @place.long.to_f
    @nearby_bars = Place.joins(:category).near([lat, long], 0.2, units: :km).where(categories: { name: 'bars' })
  end
end
