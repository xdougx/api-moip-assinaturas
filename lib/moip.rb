require "httparty"
require "json"
require "active_model"

module Moip
end

# imports para o statup
Dir["#{Dir.pwd}/lib/moip/**.rb"].each { |file| require file }

# require all models
Dir["#{Dir.pwd}/lib/moip/models/**"].each { |file| require file }

Moip.configure {|config| config.token = "3JECRRW49I3HHKHI8VC517EDMS2SS1S9"; config.acount_key = "AZQDHSQ8MSL3F57JBERR59HKBVXVDMSDXQ8V1S6V"}