class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_order
  
  def current_order(create_order_if_necessary = false)
    return @current_order if @current_order

    if session[:order_id]
      @current_order = Order.find(session[:order_id]) rescue nil
    end
    
    if create_order_if_necessary
      @current_order = Order.create if @current_order.nil?
    end

    session[:order_id] = @current_order ? @current_order.id : nil
  
    @current_order
  end  
end