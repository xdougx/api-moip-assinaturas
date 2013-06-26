module Moip
  # Configures global settings for Moip
  #   Moip.configure do |config|
  #     config.token = "secret"
  #     config.key = "secret"
  #   end
  def self.configure(&block)
    yield @config ||= Moip::Configuration.new
  end

  # Global settings for Moip
  def self.config
    @config
  end

  class Configuration
    attr_accessor :token, :acount_key, :auth_key, :env

    def initialize
      self.token = ""
      self.acount_key = ""
      self.auth_key = ""
      self.env = ""
    end
  end
end