require "active_record/time_scope/time_proxy"
require "active_record/time_scope/date_proxy"

module ActiveRecord
  module TimeScope
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      TIME_POSTFIX_REGEXP = /_(at|on|time|date)$/

      def time_scope(attr, verb: nil)
        verb = time_scope_verb(attr) if verb.nil?
        attr = "#{table_name}.#{attr}"
        proxy = TimeProxy.new(self, attr)
        declare_time_scopes verb, proxy
      end

      def date_scope(attr, verb: nil)
        verb = time_scope_verb(attr) if verb.nil?
        attr = "#{table_name}.#{attr}"
        proxy = DateProxy.new(self, attr)
        declare_time_scopes verb, proxy
      end

      private

      def declare_time_scopes(verb, proxy)
        proxy.proxy_methods.each do |method_name|
          scope_name = verb ? "#{verb}_#{method_name}" : method_name
          scope scope_name, -> (*attrs) { proxy.send method_name, *attrs }
        end
      end

      def time_scope_verb(attr)
        attr.sub TIME_POSTFIX_REGEXP, ""
      end
    end
  end
end
