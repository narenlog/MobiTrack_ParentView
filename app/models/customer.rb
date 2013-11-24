require 'securerandom'
class Customer < ActiveRecord::Base
	after_initialize :defaults

	def defaults
			self.authtoken = SecureRandom.hex(8) if self.authtoken.nil?
	end

end
