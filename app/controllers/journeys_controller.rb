class JourneysController < ApplicationController
  require 'open-uri'
  require 'json'


    def create
      @duration = (params[:duration_hours].to_i * 60) + params[:duration_minutes].to_i
      @weather_icon = params[:weather_icons]
      @journey = Journey.new(duration: @duration)
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
      @coords = @places.pluck(:long, :lat)
    end

    def localize
      puts params
    end

  private

  def journey_params
    params.require(:journey).permit(:weather_icon, category_ids: [])
  end
end
