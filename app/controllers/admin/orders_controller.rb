class Admin::OrdersController < Admin::ApplicationController
  before_filter :find_order, :only => [:show, :edit, :update, :destroy]  
    
  def show
  end
  
  def index
    @orders = Order.page(params[:page])
  end
  
  def edit
  end
  
  def update
    if  @order.address.update_attributes(params[:address])      
      redirect_to admin_order_path(@order.number)
    else
      render :edit
    end
  end
  
  def destroy
    @order.cancel
    redirect_to admin_order_path(@order.number)
  end
  
  private
  
  def find_order
    @order = Order.where(:number => params[:id]).first    
  end
end