class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable  #, :registerable
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
  attr_accessor :login
  attr_accessible :login

	def self.find_first_by_auth_conditions(warden_conditions)
		  conditions = warden_conditions.dup
		  if login = conditions.delete(:login)
		    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
		  else
		    where(conditions).first
		  end
	end
	validates :username,
	  :uniqueness => {
	    :case_sensitive => false
	  }
end
