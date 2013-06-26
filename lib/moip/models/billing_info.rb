class Moip::BillingInfo < Moip::Model

	attr_accessor :holder_name, :number, :expiration_month, :expiration_year

	validates :holder_name, :number, :expiration_month, :expiration_year, :presence => true
	
	validates_format_of :expiration_month, :with => /[0-9]{2}/
	validates_format_of :expiration_year, :with => /[0-9]{2}/
	validates_format_of :number, :with => /[0-9]{16}/
	
	validate :valida_numero_cartao


	def valida_numero_cartao
		patterns.each do |pattern|
			self.errors.add :number, "is invalid" and return if @number.to_s.match pattern
			false
		end 
	end

	# pattens validates kind of cards where is invalid in some cases like:
	# E.g.: 4444 5555 4444 6666, 1111 8888 4444 5555, 5555 6666 9999 7777 
	# has 10000 combinations
	def patterns
		@@patterns ||= []

		if @@patterns.size == 0
			for i in 0..9
				for j in 0..9
					for k in 0..9
						for l in 0..9
							@@patterns << Regexp.new("[#{i}]{4}[#{j}]{4}[#{k}]{4}[#{l}]{4}")
						end
					end
				end
			end
		end

		@@patterns
	end

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