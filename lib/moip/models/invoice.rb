class Moip::Invoice
	include HTTParty
	include Moip::Header
	
	def list
		self.class.get(base_url(:invoices), default_header).parsed_response
	end

	def create
		# todo: the create
	end

	def find
		# todo: the find
	end

	def delete
		# todo: the delete
	end
	
end