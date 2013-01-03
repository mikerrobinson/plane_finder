class School
  include Mongoid::Document
  
  attr_accessible :website, :phone, :address, :image_url, :base_airport, :name

  field :website, :type => String
  field :email, :type => String
  field :phone, :type => String
  field :address, :type => String
  field :image_url, type: String
  field :base_airport, type: String
  field :name, type: String
  
  
  field :admin_users, :type => Boolean, :default => false

  has_many :planes
  
  embeds_many :phones
  
  validates_uniqueness_of :email, :case_sensitive => false
  validates_presence_of :name

  # validate :has_contact_info

  # def has_contact_info
  #   if email.blank? and phone.blank?
  #     errors.add(:name, "Either tail number or name (or both) must be provided")
  #   end
  # end
  
end


# class User < ActiveRecord::Base
#   attr_accessible :name, :email, :password, :password_confirmation
#   has_secure_password
# 
#   before_save { |user| user.email = email.downcase }
# 
#   validates :name, presence: true, length: { maximum: 50 }
#   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
#   validates :email, presence:   true,
#                     format:     { with: VALID_EMAIL_REGEX },
#                     uniqueness: { case_sensitive: false }
#   validates :password, presence: true, length: { minimum: 6 }
#   validates :password_confirmation, presence: true
# end
