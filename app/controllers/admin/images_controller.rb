class Admin::ImagesController < Admin::ApplicationController
  before_filter :find_product
  before_filter :find_image, :only => [:destroy]
  
  def create
    @image = @product.images.new(params[:image])
    @image.save
    redirect_to admin_product_path(@product)
  end
  
  def destroy
    @image.destroy
    redirect_to admin_product_path(@product)    
  end
  
  private
  
  def find_product
    @product = Product.find(params[:product_id])
  end  
  
  def find_image
    @image = @product.images.find(params[:id])
  end
end
