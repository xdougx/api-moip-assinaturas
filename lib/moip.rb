module Moip
end

# locales
require 'i18n'
I18n.load_path << File.dirname(__FILE__) + '/moip/locale/en.yml'

# imports para o startup
require 'httparty'
require 'json'
require 'active_model'
require 'moip/header'
require 'moip/model'
require 'moip/webhooks'
require 'moip/models/address'
require 'moip/models/billing_info'
require 'moip/models/customer'
require 'moip/models/invoice'
require 'moip/models/payment'
require 'moip/models/plan'
require 'moip/models/subscription'