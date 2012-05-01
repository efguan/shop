class OrdersController < ApplicationController
  def populate
    @order = current_order(true)
    params[:variants].each do |variant_id, quantity|
      quantity = quantity.to_i
      @order.add_variant(Variant.active.find(variant_id), quantity) if quantity > 0
    end if params[:variants]
    @order.update_totals
    @order.save!
    redirect_to cart_path
  end  
      
  def edit
    @order = current_order(true)
  end  
  
  def update
    @order = current_order
    if @order.update_attributes(params[:order])
      @order.line_items = @order.line_items.select { |line_item| line_item.quantity > 0 }
      @order.update_totals
      @order.save!
      redirect_to cart_path
    else
      render :edit
    end
  end
end