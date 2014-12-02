class ReviewsController < ApplicationController
  before_filter :load_product, only: [:create]
  def show
  	@review = Review.find(params[:id])
  end

  def load_product
    @product = Product.find(params[:product_id])
  end

  def create
  	@review = @product.reviews.build(review_params)
  	@review.user = current_user

  	# if @review.save
  	# 	redirect_to products_path, notice: 'review created successfully'
  	# else
  	# 	render 'products/show'
  	# end

    respond_to do |format|
      if @review.save
        format.html { redirect_to product_path(@product.id), notice: 'Review added.' }
        format.js {} #this will look for app/views/reviews/create.js.erb
      else
        format.html { render 'products/show', alert: 'There was an error'}
        format.js {} #looks for app/views/reviews/create.js.erb
      end
    end
  end

  def destroy
  	@review = Review.find(params[:id])
  	@review.destroy
  end

  private
  def review_params
  	params.require(:review).permit(:comment, :product_id)
  end

end
