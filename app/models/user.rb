class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable :registerable,
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
  serialize :info, Hash
  attr_accessor :flick
end
