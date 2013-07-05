# encoding: utf-8
class Moip::Plan < Moip::Model
	include HTTParty
	include Moip::Header

	# see http://moiplabs.github.io/assinaturas-docs/api.html#criar_plano
	attr_accessor :code, :name, :description, :amount, 
								:setup_fee, :interval, :billing_cycles, 
								:status, :max_qty, :plans

	validates :code, :name, :amount, :presence => true

	def attributes
		{
			"code" => code,
			"name" => name, 
			"description" => description,
			"amount" => amount,
			"setup_fee" => setup_fee,
			"interval" => interval,
			"billing_cycles" => billing_cycles,
			"status" => status,
			"max_qty" => max_qty  
		}
	end

	def interval= options = {}
		@interval = {}
		@interval.merge! :length => options[:length]
		@interval.merge! :unit => options[:unit]
	end

	def interval
		return nil if @interval.nil?
		
		@interval.delete_if {|key, value| value.nil? } 
		
		if @interval.size > 0
			@interval
		else
			nil
		end
	end

	def plans= hash
		@plans = []
		hash.each do |e|
			plan = self.class.new
			plan.set_parameters e
			@plans << plan
		end
		@plans
	end

	# see http://moiplabs.github.io/assinaturas-docs/api.html#listar_plano
	def load
		list = self.class.get(base_url(:plans), default_header).parsed_response
		self.plans = list["plans"]
	end

	# metodo que envia as informações para a API do moip e cria um novo plano
	# see http://moiplabs.github.io/assinaturas-docs/api.html#criar_plano
	def create
		if self.valid?
			response = self.class.post(base_url(:plans), default_header(self.to_json)).parsed_response
			self.validate_response response
		end
			false
		else
	end

	# see http://moiplabs.github.io/assinaturas-docs/api.html#consultar_plano
	def find code
		response = self.class.get(base_url(:plans, :code => code), default_header).parsed_response
		self.set_parameters response unless response.nil?
	end

	# see http://moiplabs.github.io/assinaturas-docs/api.html#alterar_plano
	def update
		if self.valid?
			self.class.put(base_url(:plans, :code => self.code), default_header(self)).parsed_response
			true
		else
			false
		end
	end

	# see http://moiplabs.github.io/assinaturas-docs/api.html#ativar_desativar_plano
	def activate
		if self.status != "activate"
			self.status = "activate"
			self.class.put(base_url(:plans, :code => self.code, :status => "activate"), default_header).parsed_response
			true
		end
	end

	# see http://moiplabs.github.io/assinaturas-docs/api.html#ativar_desativar_plano
	def inactivate
		if self.status != "inactivate" 
			self.status = "inactivate"
			self.class.put(base_url(:plans, :code => self.code, :status => "inactivate"), default_header).parsed_response
			true
		end
	end
	
end
