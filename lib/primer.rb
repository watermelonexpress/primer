require "primer/version"

module Primer
  @services = {}
  def self.register_service name, klass
    @services[name] = klass
  end

  class PrimerError < StandardError; end
  def self.get_service name
    raise PrimerError.new("#{name} is not a registered service") unless @services.has_key? name
    @services[name]
  end
end

require "base_service"
require "runner"