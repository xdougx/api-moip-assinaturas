require "httparty"
require "json"
require "active_model"

module Moip
end

# imports para o statup
Dir["#{Dir.pwd}/lib/moip/**.rb"].each { |file| require file }

# require all models
Dir["#{Dir.pwd}/lib/moip/models/**"].each { |file| require file }
