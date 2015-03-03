require "active_record"
require "active_support/core_ext/date"
require "active_support/core_ext/time"
require "active_support/core_ext/date_time"
require "active_record/time_scope"

ActiveRecord::Base.send :include, ActiveRecord::TimeScope
