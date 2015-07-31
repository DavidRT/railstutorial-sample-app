class User < ActiveRecord::Base
	attr_accessor :remember_token
	#call back method
	# self keyword is optional in right-hand side
	before_save { self.email = email.downcase }
	validates :name, presence:true, length: {maximum: 50}
	#^ equivalent to validates(:name, presence:true)
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence:true, length: {maximum: 255},
					  format:{with: VALID_EMAIL_REGEX},
					  uniqueness: {case_sensitive: false}

	has_secure_password
	validates :password, presence:true, length:{minimum: 6}, allow_nil: true

	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
													  BCrypt::Engine.cost
		BCrypt::Password.create(string,cost: cost)
	end

	# return a random token
	def User.new_token
		SecureRandom.urlsafe_base64
	end

	# remember a user in the database for use in persistent sessions.
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	def authenticated?(remember_token)
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	# forgets a user, from remember.
	def forget
		update_attribute(:remember_digest, nil)
	end

end
