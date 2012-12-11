require 'thor'

module Primer
  class Runner < Thor
    desc "list", "List registered services"
    def list
      say "Registered services:"
      Primer.services.keys.each do |service|
        say "\u2219 #{service}"
      end
    end

    desc "status [SERVICE(s)]", "Show the status of all or a particular service"
    def status *services
      get_services(services) do |name, service|
        status = service.status
        case status[0]
        when :started
          say "\u2713 #{name} started with pid #{status[1]}.", :green
        when :stopped
          say "\u2717 #{name} stopped.", :yellow
        end
      end
    end

    desc "start SERVICE(s)", "Start a particular service"
    def start *services
      get_services(services) do |name, service|
        say "\u2219 Starting #{name}", :green
        service.start
        raise PrimerError.new("Process error #{$?}") unless ($?.exitstatus == 0)
        status name
      end
    end

    desc "stop SERVICE(s)", "Stop a particular service"
    def stop *services
      get_services(services) do |name, service|
        say "\u2219 Stopping #{name}", :green
        service.stop
        raise PrimerError.new("Process error #{$?}") unless ($?.exitstatus == 0)
        status name
      end
    end

    desc "restart SERVICE(s)", "Restart a particular service"
    def restart *services
      get_services(services) do |name, service|
        say "\u2219 Restarting #{name}", :green
        service.restart
        status name
      end
    end

    private
    def get_services services, &block
      services = Primer.services.keys if services.size == 0 and services[0].nil?
      services.each do |service_name|
        begin
          yield service_name, Primer::get_service(service_name).new()
        rescue PrimerError => pe
          say "\u2717 #{pe.message}", :red
        rescue Object => e
          say "\u2717 #{e.message}", :red
        end
      end
    end
  end
end