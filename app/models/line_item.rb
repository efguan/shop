class LineItem
  include Mongoid::Document
  include Mongoid::Timestamps

  field :quantity, :type => Integer
  field :price, :type => Float
  field :props, :type => Hash, :default => {}
  
  belongs_to :order
  belongs_to :variant
  
  attr_accessible :quantity
  
  def amount
    self.price * self.quantity
  end
end