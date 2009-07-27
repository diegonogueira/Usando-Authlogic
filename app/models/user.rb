class User < ActiveRecord::Base
	acts_as_authentic	

	def deliver_password_reset_instructions!
		reset_perishable_token!	  	
	end	
	
end
