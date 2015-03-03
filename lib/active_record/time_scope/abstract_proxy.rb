module ActiveRecord
  module TimeScope
    class AbstractProxy
      attr_reader :model, :attr

      def initialize(model, attr)
        @model = model
        @attr = attr
      end

      def proxy_methods
        []
      end
    end
  end
end
