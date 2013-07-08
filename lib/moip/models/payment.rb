class Moip::Payment < Moip::Model
	include HTTParty
	include Moip::Header
	
	attr_accessor :id, :moip_id, :status, :subscription_code, 
								:customer_code, :invoice, :payment_method,
								:creation_date

	def attributes
		{ 
			"id" => id,
			"moip_id" => moip_id,
			"status" => status,
			"subscription_code" => subscription_code,
			"customer_code" => customer_code,
			"invoice" => invoice,
			"payment_method" => payment_method,
			"creation_date" => creation_date
		}
	end

	def payments= hash
		@payments = []
		hash.each do |e|
			payment = self.class.new
			payment.set_parameters e
			@payments << payment
		end
		@payments
	end

	def payments
		@payments ||= self.payments = self.load
	end

	def load
		list = self.class.get(base_url(:invoices, :code => self.subscription_code, :status => "payments"), default_header).parsed_response
		self.payments = list["payments"]
	end

	def find
		response = self.class.get(base_url(:payments, :code => self.id), default_header).parsed_response
		self.set_parameters response unless response.nil?
	end

	def retry
		response = self.class.get(base_url(:payments, :code => self.id, :status => "retry"), default_header).parsed_response
	end

	def self.retry id
		response = self.class.get(base_url(:payments, :code => id, :status => "retry"), default_header).parsed_response
	end
	
end