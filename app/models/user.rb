class User
  include Mongoid::Document
  include Mongoid::Timestamps
  
  # Database authenticatable
  field :email
  field :encrypted_password
  # Rememberable
  field :remember_created_at, :type => Time
  
  # Include devise modules
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  def admin?
    Setting.admin_emails.include?(self.email)
  end  
end