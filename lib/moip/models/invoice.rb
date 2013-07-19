#encoding: utf-8
class Moip::Invoice < Moip::Model
	include HTTParty
	include Moip::Header

	attr_accessor :id, :amount, :subscription_code, :occurrence, 
	              :status, :items, :plan, :customer, :creation_date, :invoices

	def attributes
		{
			"id" => id,
			"amount" => amount,
			"subscription_code" => subscription_code,
			"occurrence" => occurrence,
			"status" => status,
			"items" => items,
			"plan" => plan,
			"customer" => customer,
			"creation_date" => creation_date
		}
	end
	
	def invoices= hash
		@invoices = []
		hash.each do |e|
			invoice = Moip::Invoice.new
			invoice.set_parameters e
			@invoices << invoice
		end
		@invoices
	end

	def full_status
		status = case self.status
			when 1 then "Em aberto" # A fatura foi gerada mas ainda não foi paga pelo assinante.
			when 2 then "Aguardando Confirmação" # A fatura foi paga pelo assinante, mas o pagamento está em processo de análise de risco.
			when 3 then "Pago" # A fatura foi paga pelo assinante e confirmada.
			when 4 then "Não Pago" # O assinante tentou pagar a fatura, mas o pagamento foi negado pelo banco emissor do cartão de crédito ou a análise de risco detectou algum problema. Veja os motivos possíveis.
			when 5 then "Atrasada" # O pagamento da fatura foi cancelado e serão feitas novas tentativas de cobrança de acordo com a configuração de retentativa automática.
		end
		status
	end

	def invoices
		@invoices ||= self.invoices = self.load
	end

	def load
		list = self.class.get(base_url(:subscriptions, :code => self.subscription_code, :status => "invoices"), default_header).parsed_response
		self.invoices = list["invoices"]
	end

	def find
		response = self.class.get(base_url(:invoices, :code => self.id), default_header).parsed_response
		self.set_parameters response unless response.nil?
	end

	def payments
		@payments ||= Moip::Payment.build(:invoice => self.id).payments
	end
	
end