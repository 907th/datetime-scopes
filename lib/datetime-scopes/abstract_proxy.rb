module DateTimeScopes
  class AbstractProxy
    def initialize(attribute:, time_zone:)
      @attribute = attribute
      @time_zone = time_zone
    end

    def proxy_methods
      raise "Must be implemented in sub-class"
    end
  end
end
