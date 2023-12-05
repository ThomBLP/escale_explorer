class PagesController < ApplicationController
  
  def home
    @categories = Category.all
    @journey = Journey.new
  end
end
