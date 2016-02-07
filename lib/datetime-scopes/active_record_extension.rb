require_relative "datetime_proxy"
require_relative "date_proxy"

module DateTimeScopes
  module ActiveRecordExtension
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def datetime_scopes(attr, prefix: nil, time_zone: ::Time.zone)
        proxy = DateTimeProxy.new(
          klass: self,
          attribute: "#{table_name}.#{attr}",
          time_zone: time_zone
        )
        prefix = datetime_scope_prefix(attr) if prefix.nil?
        declare_datetime_scopes prefix, proxy
      end

      def date_scopes(attr, prefix: nil, time_zone: nil)
        proxy = DateProxy.new(
          klass: self,
          attribute: "#{table_name}.#{attr}",
          time_zone: time_zone
        )
        prefix = datetime_scope_prefix(attr) if prefix.nil?
        declare_datetime_scopes prefix, proxy
      end

      private

      def declare_datetime_scopes(prefix, proxy)
        proxy.proxy_methods.each do |method_name|
          scope_name = "#{prefix}_#{method_name}"
          scope scope_name, -> (*attrs) { proxy.send method_name, *attrs }
        end
      end

      def datetime_scope_prefix(attr)
        attr.to_s.sub /_(at|on|time|date)$/, ""
      end
    end
  end
end
