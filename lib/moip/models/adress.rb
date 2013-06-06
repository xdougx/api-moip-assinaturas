class Moip::Adress < Moip::Model
	
	attr_accessor :street, :number, :complement, 
								:district, :city, :state, :country, :zipcode

	validates :street, :state, :country, :zipcode, :presence => true

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