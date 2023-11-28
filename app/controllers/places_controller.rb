class PlacesController < ApplicationController
  def index
    @places = if params[:place] && params[:place][:name].present?
                Place.where("name LIKE ?", "%#{params[:place][:name]}%")
              else
                Place.all
              end
  end
  
  def show
  end
end
