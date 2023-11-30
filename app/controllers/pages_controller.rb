class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @categories = Category.all
    # @ip = request.remote_ip
    # @city = GeolocService.localize_me
  end
end
