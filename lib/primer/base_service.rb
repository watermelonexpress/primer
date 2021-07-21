module Primer
  class BaseService
    class << self
      attr_reader :running_command, :port, :repo_name

      def set_port(port)
        @port = port
      end

      def set_repo_name(repo_name)
        @repo_name = repo_name
      end

      def set_running_command(command)
        @running_command = command
      end

      def register(name)
        Primer.register(name, self)
      end
    end

    def start
      raise Primer::PrimerError.new("Please implement the 'start' method in your service.")
    end

    def stop
      raise Primer::PrimerError.new("Please implement the 'stop' method in your service.")
    end

    def status
      pid = `ps -ef | grep "#{self.class.running_command}" | grep -v grep | grep -v primer | awk '{ print $2 }'`
      if pid.nil?
        stopped = true
      else
        pid = pid.to_i
        if pid > 0
          stopped = false
        else
          stopped = true
        end
      end

      status = stopped ? :stopped : :started
      [status, pid]
    end

    def restart
      stop
      start
    end

    protected
    def run(command)
      Bundler.with_clean_env do
        system command
      end
    end
  end
end
