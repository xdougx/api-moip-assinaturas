class Moip::BillingInfo < Moip::Model

	attr_accessor :holder_name, :number, :expiration_month, :expiration_year

	validates :holder_name, :number, :expiration_month, :expiration_year, :presence => true
	
	validates_format_of :expiration_month, :with => /[0-9]{2}/
	validates_format_of :expiration_year, :with => /[0-9]{2}/
	validates_format_of :number, :with => /[0-9]{16}/


	def attributes
		{
			"holder_name" => holder_name,
	    "number" => number,
	    "expiration_month" => expiration_month,
	    "expiration_year" => expiration_year 
  	}
	end

	def to_json
		hash = { :credit_card => self.serializable_hash }
		hash.to_json
	end

	def to_hash
		 { :credit_card => self.serializable_hash }
	end

end