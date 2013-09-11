# encoding: utf-8
module Moip
	class Model		
		include ActiveModel::Validations
		include ActiveModel::Serialization

		def to_json
			hash = self.serializable_hash.delete_if {|key, value| value.nil? }
			hash.to_json
		end

		def set_parameters params
			params.each do |key, value|
				self.send("#{key}=".to_sym, value)
			end
		end

		def validate_response response
			if response.key? "errors" and response["errors"].size > 0
				error = response["errors"][0]
				self.errors.add :moip_error, "#{error["description"]}"
				false
			else
				true
			end
		end

		class << self
			# metodo que cria um objeto e seta os seus parametros se responder pela chave
			# recebe um Hash como parametro
			def build params
				if params.is_a? Hash
					object = new
					
					params.each do |key, value|
						object.send("#{key}=".to_sym, value) if object.respond_to? key.to_sym
					end

					object
				else
					raise Exception.new "unexpected parameter, expected Hash, received #{params.class}"
				end
			end
		end

	end
end