class PlacesController < ApplicationController
  def index
    @journey   = Journey.find(params[:journey_id])
    @rest_time = @journey.duration - @journey.total_duration
    @places    = Place.where.not(id: @journey.place_ids)

    if params[:keyword].present?
      @places = @places.where('name ILIKE ?', "%#{params[:keyword]}%")
    else
      @places = @places.where(category_id: params[:category_ids])
                      .where.not("weather_icons::text LIKE ?", "%#{@journey.weather_icon}%")
                      .where("visit_duration <= ?", @rest_time)
    end

    @places = @places.first(20)

    if params[:lat] && params[:long]
      @latitude  = params[:lat]
      @longitude = params[:long]
    end

    @categories = Category.all


    respond_to do |format|
      format.html
      format.text { render partial: "places/list", locals: { places: @places, rest_time: @rest_time }, formats: [:html] }
    end
  end

  def show
    @journey = Journey.find(params[:journey_id])
    @place = Place.find(params[:id])
    @categories = Category.all
  end

  def nearby_restaurants
    @journey = Journey.find(params[:journey_id])

    @place = Place.find(params[:id])
    lat = @place.lat.to_f
    long = @place.long.to_f
    @nearby_restaurants = Place.joins(:category).near([lat, long], 0.2, units: :km).where(categories: { name: 'restaurants' })

    @markers = @nearby_restaurants.map do |place|
      {
        lng: place.long,
        lat: place.lat,
        name: place.name
      }
    end

    @monument_marker = {
      lng: @place.long,
      lat: @place.lat
    }

  end

  def nearby_bars
    @journey = Journey.find(params[:journey_id])
    @place = Place.find(params[:id])
    lat = @place.lat.to_f
    long = @place.long.to_f
    @nearby_bars = Place.joins(:category).near([lat, long], 0.2, units: :km).where(categories: { name: 'bars' })

    @markers = @nearby_bars.map do |place|
      {
        lng: place.long,
        lat: place.lat,
        name: place.name
      }
    end

    @monument_marker = {
      lng: @place.long,
      lat: @place.lat
    }
  end

end
