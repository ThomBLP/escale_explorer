class CheckcardController < ApplicationController
  def index
    @places = Place.all
  end
end
