class Moip::Address < Moip::Model
	
	attr_accessor :street, :number, :complement, 
								:district, :city, :state, :country, :zipcode

	validates :street, :number, 
						:district, :city, :state, :country, 
						:zipcode, :presence => true

	validate :validates_format_of_number, :validates_format_of_zipcode

	def validates_format_of_number
		if self.number.to_s.match /[0-9]{2}/
			true
		else
			self.errors.add :number, I18n.t("moip.errors.invalid_format")
		end
	end

	def validates_format_of_zipcode
		if self.zipcode.to_s.match /[0-9]{2}/
			true
		else
			self.errors.add :zipcode, I18n.t("moip.errors.invalid_format")
		end
	end

	def attributes
		{
			"street" => street,
			"number" => number,
			"complement" => complement,
			"district" => district,
			"city" => city,
			"state" => state,
			"country" => country,
			"zipcode" => zipcode
		}
	end

end