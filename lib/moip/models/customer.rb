# encoding: utf-8
class Moip::Customer < Moip::Model
	include HTTParty
	include Moip::Header

	# see http://moiplabs.github.io/assinaturas-docs/api.html#criar_cliente
	attr_accessor :code, :email, :fullname, :cpf, :phone_area_code, 
								:phone_number, :birthdate_day, :birthdate_month, 
								:birthdate_year, :address, :billing_info, :customers, 
								:creation_date, :creation_time

	validates :code, :email, :fullname, :cpf, :phone_area_code, 
						:phone_number, :birthdate_day, :birthdate_month, 
						:birthdate_year, :presence => true

	validate :validates_presence_of_address, :validates_presence_of_billing_info, :validates_format_of_email

	def attributes
		{
	    "code" => code,
	    "email" => email,
	    "fullname" => fullname,
	    "cpf" => cpf,
	    "phone_area_code" => phone_area_code,
	    "phone_number" => phone_number,
	    "birthdate_day" => birthdate_day,
	    "birthdate_month" => birthdate_month,
	    "birthdate_year" => birthdate_year,
	    "address" => address,
	    "billing_info" => billing_info
		}
	end

	def address= options = {}
		if options.is_a? Hash
			@address = Moip::Address.build options
		elsif options.is_a? Moip::Address
			@address = options
		end
	end

	def address
		@address.serializable_hash.delete_if {|key, value| value.nil? }
	end

	def billing_info= options = {}
		if options.is_a? Hash
			@billing_info = Moip::BillingInfo.build options
		elsif options.is_a? Moip::BillingInfo
			@billing_info = options
		end
	end

	def billing_info
		@billing_info.to_hash
	end

	def validates_presence_of_address
		self.errors.add :address, I18n.t("moip.errors.presence_of_address") and return if @address.nil?

		if @address.valid?
			true
		else
			self.errors.add @address.errors.first[0], @address.errors.first[1]
		end
	end

	def validates_presence_of_billing_info
		self.errors.add :billing_info, I18n.t("moip.errors.presence_of_billing_info") and return if @billing_info.nil?

		if @billing_info.valid?
			true
		else
			self.errors.add @billing_info.errors.first[0], @billing_info.errors.first[1]
		end
	end

	def validates_format_of_email
		if self.email.match /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
			true
		else
			self.errors.add :email, I18n.t("moip.errors.invalid_format") and return
		end
	end

	def customers= hash
		@customers = []
		hash.each do |e|
			customer = self.class.new
			customer.set_parameters e
			@customers << customer
		end
		@customers
	end


	def load
		list = self.class.get(base_url(:customers), default_header).parsed_response
		self.costumers = list["costumers"]
	end

	# metodo que envia as informações para a API do moip e cria um novo cliente
	# see http://moiplabs.github.io/assinaturas-docs/api.html#criar_cliente
	def create
		if self.valid?
			response = self.class.post(base_url(:customers, :params => "new_vault=true"), default_header(self.to_json)).parsed_response
			self.validate_response response
		else
			false
		end
	end


	# metodo que envia as informações para a API do moip e atualiza os dados do cartão
	# see http://moiplabs.github.io/assinaturas-docs/api.html#atualizar_cartao
	def update_billing_info billing_info
		if billing_info.valid?
			response = self.class.put(base_url(:customers, :code => self.code, :status => "billing_infos"), default_header(billing_info.build_update.to_json)).parsed_response
			puts response
			self.validate_response response
		else
			false
		end
	end

	
	def find code
		response = self.class.get(base_url(:customers, :code => code), default_header).parsed_response
		self.set_parameters response unless response.nil?
	end
	
end