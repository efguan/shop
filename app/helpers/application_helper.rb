module ApplicationHelper  
  def page_title
    if @page_title
      "#{@page_title}"
    else
      "The Shop Startup"
    end
  end
end
