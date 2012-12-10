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

    desc "start SERVICE", "Start a particular service"
    def start service
      say "\u2219 Starting #{service}", :green
      do_action service, :start
    end

    desc "stop SERVICE", "Stop a particular service"
    def stop service
      say "\u2219 Stopping #{service}", :green
      do_action service, :stop
    end

    desc "restart SERVICE", "Restart a particular service"
    def restart service
      say "\u2219 Restarting #{service}", :green
      do_action service, :restart
    end

    private
    def do_action service_name, action
      begin
        service = Primer::get_service(service_name).new()
        raise Primer::PrimerError.new("Invalid action: #{action}") unless service.respond_to? action
        service.send action
        case action
        when :start
          say "\u2713 #{service_name} started."
        when :stop
          say "\u2713 #{service_name} stopped."
        end
      rescue PrimerError => pe
        say "\u2717 #{pe.message}", :red
      rescue Object => e
        say "\u2717 #{e.message}", :red
      end
    end
  end
end