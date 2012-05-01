class Admin::VariantsController < Admin::ApplicationController
  before_filter :find_product
  before_filter :find_variant, :only => [:edit, :update, :destroy]
  
  def new
    last_variant = @product.variants.active.last
    return render :prop unless last_variant
    @variant = @product.variants.new(:props => last_variant.props)
  end
  
  def create
    @variant = @product.variants.new(params[:variant])
    if save_variant
      redirect_to admin_product_path(@product)
    else
      render :new
    end    
  end
  
  def edit
  end
  
  def update
    if save_variant
      redirect_to admin_product_path(@product)
    else
      render :edit
    end    
  end
  
  def destroy
    @variant.update_attributes(:deleted_at => Time.now)
    @product.update_attributes(:available => false) unless @product.variants.active.last
    redirect_to admin_product_path(@product)
  end
  
  private
  
  def find_product
    @product = Product.find(params[:product_id])
  end
  
  def find_variant
    @variant = @product.variants.active.find(params[:id])
  end
  
  def save_variant
    @variant.props = Hash[params[:variant_options].map{ |option| [option, nil] }] if params[:variant_options]
    @variant.props = Hash[params[:variant_options].zip(params[:variant_values])] if params[:variant_values]
    
    if @variant.new_record?
      @variant.save 
    else
      @variant.update_attributes(params[:variant])
    end
  end
end