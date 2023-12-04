class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def create
    @journey      = Journey.find(params[:journey_id])
    @visit        = Visit.find(params[:visit_id])
    @review       = Review.new(review_params)
    @review.visit = @visit
    if @review.save
      redirect_to journey_path(@journey), notice: "Review created successfully"
    else
      render "journeys/show"
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating)
  end
end
