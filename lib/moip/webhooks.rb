module Moip
	# see http://moiplabs.github.io/assinaturas-docs/webhooks.html
	class Webhooks
		attr_accessor :event, :date, :env, :resource

		def events
			@events ||= {}
		end

		def on event, kind, &block
			self.events[event] = { :kind => kind, :runnable => block }
		end

		def run
			event = self.event.split(".")[0]
			kind = self.event.split(".")[1]
			action = nil

			self.events.each do |key, hash|
				if event == key.to_s and hash[:kind].to_s == kind
					action = hash[:runnable]
				end
			end
			action.call if action.is_a? Proc
		end

		def resource= params
			klass = "Moip::#{self.event.split(".")[0].capitalize}" # E.g Moip::Plan when event plan.created
			klass = eval klass
			@resource = klass.build params
		end

		class << self	
			def build params
				object = new
				
				params.each do |key, value|
					object.send("#{key}=".to_sym, value) if object.respond_to? key.to_sym
				end

				object
			end

			def listen(json, &block)
				hook = build json
				yield hook
				hook.run
			end
		end

	end
end