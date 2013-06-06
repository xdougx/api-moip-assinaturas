module Moip
	module Header
		def default_header json = nil
			header = {}
			header.merge! :basic_auth => auth
			header.merge! :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
			header.merge! :body => json if json

			header
		end

		def auth
			@auth ||= {:username => Moip.config.token, :password => Moip.config.acount_key}
		end

		def base_url model, options = {}
			url = "https://sandbox.moip.com.br/assinaturas/v1/#{model.to_s}" 
			url << "/#{options[:code]}" 	if options[:code]
			url << "/#{options[:status]}" if options[:status]
			url << "?#{options[:params]}" if options[:params]
			url
		end

	end
end