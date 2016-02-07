require "active_record"
require "active_support/core_ext/date"
require "active_support/core_ext/time"
require "active_support/core_ext/date_time"

require "datetime-scopes/active_record_extension"

ActiveRecord::Base.send :include, DateTimeScopes::ActiveRecordExtension
