# encoding: utf-8
class Moip::Subscription < Moip::Model
	include HTTParty
	include Moip::Header

	attr_accessor :code, :amount, :plan, :customer, 
                :next_invoice_date, :status, :message, 
                :invoice, :creation_date, 
                :expiration_date, :subscriptions

	validates :code, :amount, :plan, :customer, :presence => true

	def attributes
		{
	    "code" => code,
	    "amount" => amount,
	    "plan" => plan,
	    "customer" => customer
		}
	end

	def plan
		if @plan.is_a? Hash
			@plan
		else
			return nil if @plan.nil?
			@plan = { :code => @plan }
			@plan
		end
	end

	def customer
		if @customer.is_a? Hash
			@customer
		else
			return nil if @customer.nil?
			@customer ={ :code => @customer }
			@customer
		end
	end

	def subscriptions= hash
		@subscriptions = []
		hash.each do |e|
			subscription = self.class.new
			subscription.set_parameters e
			@subscriptions << subscription
		end
		@subscriptions
	end

	def subscriptions
		@subscriptions
	end

	def invoices		
		@invoices ||= Moip::Invoice.build(:subscription_code => self.code).invoices
	end

	# see http://moiplabs.github.io/assinaturas-docs/api.html#listar_assinaturas
	def load
		list = self.class.get(base_url(:subscriptions), default_header).parsed_response
		self.subscriptions = list["subscriptions"]
	end

	# see http://moiplabs.github.io/assinaturas-docs/api.html#criar_assinatura
	def create
		if self.valid?
			response = self.class.post(base_url(:subscriptions), default_header(self.to_json)).parsed_response
			self.validate_response response
		else
			false
		end
	end

	# To Do
	def create_with_costumer
		# To Do: will not be developed this feature right now, if you
		#       want to fork and develop this feature, be welcome.
	end

	# see http://moiplabs.github.io/assinaturas-docs/api.html#consultar_assinatura
	def find code
		response = self.class.get(base_url(:subscriptions, :code => code), default_header).parsed_response
		self.set_parameters response unless response.nil?
	end

	def suspend
		if self.status != "suspend"
			self.status = "suspend"	
			self.class.put(base_url(:subscriptions, :code => self.code, :status => "suspend"), default_header).parsed_response
			true
		end
	end

	def activate
		if self.status != "activate"
			self.status = "activate"
			self.class.put(base_url(:subscriptions, :code => self.code, :status => "activate"), default_header).parsed_response
			true
		end
	end
	
	def cancel
    if self.status != "cancel"
      self.status = "cancel" 
      self.class.put(base_url(:subscriptions, :code => self.code, :status => "cancel"), default_header).parsed_response
      true
    end
  end

	# see http://moiplabs.github.io/assinaturas-docs/api.html#alterar_assinatura
	def update_plan new_plan
		hash = {}
		hash[:plan] = { :code => new_plan }

		self.class.put(base_url(:subscriptions, :code => self.code), default_header(hash.to_json)).parsed_response
	end

	# see http://moiplabs.github.io/assinaturas-docs/api.html#alterar_assinatura
	def update_next_invoice plan, next_invoice_date
		hash = {}
		hash[:plan] = { :code => plan }
		hash[:next_invoice_date] = next_invoice_date

		self.class.put(base_url(:subscriptions, :code => self.code), default_header(hash.to_json)).parsed_response
	end

	def update_amount plan, new_amount
		hash = {}

		self.find self.code

		hash[:plan] = { :code => plan }
		hash[:amount] = new_amount

		self.class.put(base_url(:subscriptions, :code => self.code), default_header(hash.to_json)).parsed_response
	end
end