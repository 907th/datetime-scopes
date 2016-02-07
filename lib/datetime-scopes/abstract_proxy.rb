module DateTimeScopes
  class AbstractProxy
    def initialize(klass:, attribute:, time_zone:)
      @klass = klass
      @attribute = attribute
      @time_zone = time_zone
    end

    def proxy_methods
      raise "Must be implemented in sub-class"
    end
  end
end
