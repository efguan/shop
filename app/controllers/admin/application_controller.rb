class Admin::ApplicationController < ApplicationController
  layout 'admin'
  before_filter :require_admin

  protected

  def require_admin
    return if user_signed_in? && current_user.admin?
    render_404
  end
  
  def render_404(exception = nil)
    respond_to do |format|
      format.html { render :status => :not_found, :file => "#{Rails.root}/public/404", :formats => [:html], :layout => nil }
      format.all  { render :status => :not_found, :nothing => true }
    end
  end
end
