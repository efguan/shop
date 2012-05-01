class Order
  include Mongoid::Document
  include Mongoid::Timestamps  

  field :number
  field :total, :type => Float
  
  has_many :line_items, :autosave => true
  
  accepts_nested_attributes_for :line_items
  
  before_validation :generate_number, :on => :create
  
  validates :number, :presence => true
      
  def contains?(variant)
    line_items.detect { |line_item| line_item.variant_id == variant.id }
  end
  
  def generate_number
    record = true
    while record
      random = "#{Array.new(9){rand(9)}.join}"
      record = self.class.where(:number => random).first
    end
    self.number = random if self.number.blank?
    self.number
  end
  
  def add_variant(variant, quantity = 1)
    current_item = contains?(variant)
    if current_item
      current_item.quantity += quantity
      current_item.save
    else
      current_item = LineItem.new(:quantity => quantity)
      current_item.variant = variant
      current_item.price   = variant.price
      current_item.props   = variant.props
      self.line_items << current_item
    end
    current_item
  end

  def update_totals
    # updates order adjustment_total, item_total, total, etc.
    item_total = line_items.map(&:amount).sum
    self.total = item_total
  end
end