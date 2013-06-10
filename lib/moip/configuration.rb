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
    attr_accessor :token, :acount_key

    def initialize
      self.token = ""
      self.acount_key = ""
    end
  end
end