require "primer/version"

module Primer
  def self.load_services glob
    glob.each do |file|
      require file
    end
  end

  def self.services
    @services ||= {}
  end

  def self.register name, klass
    Primer.services[name] = klass
  end

  class PrimerError < StandardError; end
  def self.get_service name
    raise PrimerError.new("#{name} is not a registered service") unless Primer.services.has_key? name
    Primer.services[name]
  end

  def self.run_services services, action
    runner = Primer::Runner.new
    services.each do |service|
      runner.send action.to_sym, service
    end
  end
end

require "primer/base_service"
require "primer/runner"