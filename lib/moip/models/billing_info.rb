class Moip::BillingInfo < Moip::Model

	attr_accessor :holder_name, :number, :expiration_month, :expiration_year

	validates :holder_name, :number, :expiration_month, :expiration_year, :presence => true

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