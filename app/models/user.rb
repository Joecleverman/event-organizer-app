class User < ActiveRecord::Base
    has_one :event
    has_many :attenders, through: :event
    has_many :contractors, through: :event
    has_secure_password
    validates_presence_of :username, :email
  
  end