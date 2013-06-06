# encoding: utf-8
class Moip::ACostumer < Moip::Model
	include HTTParty
	include Moip::Header

	# see http://moiplabs.github.io/assinaturas-docs/api.html#criar_plano
	attr_accessor :code, :email, :fullname, :cpf, :phone_area_code, 
								:phone_number, :birthdate_day, :birthdate_month, 
								:birthdate_year, :adress, :billing_info

	validates :code, :email, :fullname, :cpf, :phone_area_code, 
						:phone_number, :birthdate_day, :birthdate_month, 
						:birthdate_year, :presence => true

	validate :validates_presence_of_adress, :validates_presence_of_billing_info

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
	    "adress" => adress,
	    "billing_info" => billing_info
		}
	end

	def adress= options = {}
		@adress = Adress.build options
	end

	def adress
		@adress.serializable_hash
	end

	def billing_info= options
		if options.is_a? Hash
			@billing_info = BillingInfo.build options
		elsif options.is_a? BillingInfo
			@billing_info = BillingInfo
		end
	end

	def billing_info
		@billing_info.to_hash
	end

	def validates_presence_of_adress
		self.errors.add :adress, "can't be blank" and return if @adress.nil?

		if @adress.valid?
			true
		else
			self.errors.add :adress, @adress.errors.full_messages.first
		end
	end

	def validates_presence_of_billing_info
		self.errors.add :billing_info, "can't be blank" and return if @billing_info.nil?

		if @billing_info.valid?
			true
		else
			self.errors.add :adress, @billing_info.errors.full_messages.first
		end
	end


	def list
		self.class.get(base_url(:costumers), default_header).parsed_response
	end

	# metodo que envia as informações para a API do moip e cria um novo cliente
	# see http://moiplabs.github.io/assinaturas-docs/api.html#criar_cliente
	def create
		if self.valid?
			self.class.post(base_url(:costumers, :params => "new_vault=true"), default_header(self.to_json)).parsed_response
		else
			raise Exception.new "#{self.errors.first[0]} #{self.errors.first[1]}"
		end
	end

	def find
		# todo: the find
	end

	def delete
		# todo: the delete
	end
	
end