class HomeController < ApplicationController
  def index
    @products = Product.published
    @variant = Variant.active.find(params[:variant_id]) if params[:variant_id]
    respond_to do |format|
      format.js { render :layout => false }
      format.html
    end
  end
end