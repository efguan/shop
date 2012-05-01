class Admin::ProductsController < Admin::ApplicationController
  before_filter :find_tags, :only => [:tagged, :index]  
  before_filter :find_product, :only => [:show, :edit, :update, :destroy]
  
  def tagged
    @products = Product.active.where(:tags => params[:tag]).page(params[:page])
    render :index
  end
  
  def show
    @image = Image.new
    @variant = Variant.new
  end
  
  def index
    @products = Product.active
    redirect_to new_admin_product_path and return if @products.empty? 
    @products = @products.page(params[:page])
  end
  
  def new
    @brands = Product.active.map(&:brand).compact.uniq
    @departments = Product.active.map(&:department).compact.uniq
    @product = Product.new
  end

  def create
    @product = Product.new params[:product]
    if @product.save
      redirect_to admin_product_path(@product)
    else      
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @product.update_attributes params[:product]
      redirect_to admin_product_path(@product)
    else
      render :edit
    end
  end
  
  def destroy
    @product.update_attributes(:deleted_at => Time.now)
    redirect_to admin_products_path
  end

  private
  
  def find_tags
    @tags = Product.active.map(&:tags).flatten.uniq
  end
  
  def find_product
    @product = Product.find(params[:id])
  end  
end