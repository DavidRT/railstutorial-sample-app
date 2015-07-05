class User < ActiveRecord::Base
	#call back method
	# self keyword in optional in right-hand side
	before_save { email.downcase! }
	validates :name, presence:true, length: {maximum: 50}
	#^ equivalent to validates(:name, presence:true)
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence:true, length: {maximum: 255},
					  format:{with: VALID_EMAIL_REGEX},
					  uniqueness: {case_sensitive: false}

	has_secure_password
	validates :password, presence:true, length:{minimum: 6}
end