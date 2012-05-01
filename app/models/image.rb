class Image
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  
  field :position, :type => Integer, :default => 0
  field :attachment
  
  belongs_to :product
  
  mount_uploader :attachment, ImageUploader
end