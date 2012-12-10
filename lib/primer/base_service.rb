module Primer
  class BaseService
    def self.register name
      Primer.register name, self
    end

    def start
      raise Primer::PrimerError.new("Please implement the 'start' method in your service.")
    end

    def stop
      raise Primer::PrimerError.new("Please implement the 'stop' method in your service.")
    end

    def restart
      stop
      start
    end
  end
end