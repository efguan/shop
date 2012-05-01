class Variant
  include Mongoid::Document
  include Mongoid::Timestamps

  field :state
  field :price, :type => Float
  field :props, :type => Hash, :default => {}  
  field :sku
  field :deleted_at
  
  belongs_to :product
  
  validates :price, :presence => true
  
  scope :active, where(:deleted_at => nil)

  # all states maybe %w(in_stock available_for_order out_of_stock preorder)
  def self.states
    %w(available_for_order out_of_stock)
  end  
  
  # strips all non-price-like characters from the price.  
  def price=(price)
    if price.present?
      self[:price] = price.to_s.gsub(/[^0-9\.-]/,'').to_f
    end
  end
  
  def available_for_order?
    self.state == 'available_for_order'
  end
  
  def out_of_stock?
    self.state == 'out_of_stock'
  end
end