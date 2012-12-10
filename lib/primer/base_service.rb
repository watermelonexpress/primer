module Primer
  class BaseService
    def self.register name
      Primer.register name, self
    end
  end
end