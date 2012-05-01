class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :token
  field :title
  field :brand
  field :department  
  field :description
  field :tags, :type => Array, :default => []
  field :available_on, :type => Time
  field :deleted_at  
  
  has_many :images
  has_many :variants
  
  attr_accessible :title, :brand, :department, :description, :available, :tag_string
  
  before_validation :generate_token, :on => :create
    
  validates :token, :title, :presence => true
  
  scope :active, where(:deleted_at => nil)
  scope :deleted, where(:deleted_at.exists => true)
  scope :published, active.where(:available_on.ne => nil)

  def self.brands
    Product.active.map(&:brand).compact.uniq - ['']
  end
  
  def self.departments
    Product.all.map(&:department).compact.uniq - ['']
  end  

  def tag_string
    self.tags.join(', ')
  end
  
  def tag_string=(string)
    self.tags = string.to_s.downcase.split(/[,\s]+/).uniq
  end
  
  def available
    !!available_on
  end
    
  def available=(value)
    self.available_on = value == '1' ? Time.now : nil
  end  
  
  def deleted?
    !!deleted_at
  end  

  def available?
    !deleted_at && !!available_on
  end  

  def variant_options
    values = []
    self.variants.active.each do |variant|
      values << [variant.props.values.join(' - '), variant.id]
    end
    values
  end

  def image
    self.images.first.attachment if self.images.present?
  end
          
  def generate_token
    record = true
    while record
      charts = ('a'..'z').to_a + ('A'..'Z').to_a + ('1'..'9').to_a - %w(I i L l O o Z z)
      random = Array.new(6){charts[rand(charts.size)]}.join
      record = self.class.where(:token => random).first
    end
    self.token = random if self.token.blank?
    self.token
  end
end