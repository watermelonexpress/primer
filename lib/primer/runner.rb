require 'thor'

module Primer
  class Starter < Thor
    desc "start SERVICE", "Start a particular service"
    def start service
      puts "Rails root - #{::Rails.root}"
      say "Starting #{service}", :green
      do_action service, :start
    end

    desc "stop SERVICE", "Stop a particular service"
    def stop service
      say "Stopping #{service}", :green
      do_action service, :stop
    end

    desc "restart SERVICE", "Restart a particular service"
    def restart service
      say "Restarting #{service}", :green
      do_action service, :restart
    end

    private
    def do_action service, action
      begin
        Primer::get_service(service).new().send action
      rescue PrimerError => pe
        say pe.message, :red
      rescue Object
        say "Catastrophic error.", :red
      end
    end
  end
end