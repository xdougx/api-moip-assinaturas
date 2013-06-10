class Moip::Address < Moip::Model
	
	attr_accessor :street, :number, :complement, 
								:district, :city, :state, :country, :zipcode

	validates :street, :number, 
						:district, :city, :state, :country, 
						:zipcode, :presence => true

	validates_format_of :number, :with => /[0-9]{1,6}/
	validates_format_of :zipcode, :with => /[0-9]{8}/

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