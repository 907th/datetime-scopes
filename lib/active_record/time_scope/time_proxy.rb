require "active_record/time_scope/abstract_proxy"

module ActiveRecord
  module TimeScope
    class TimeProxy < AbstractProxy
      PROXY_METHODS = %w[
        within
        within_days
        within_months
        within_years
        at_day
        at_month
        at_year
        before
        before_day
        before_month
        before_year
        after
        after_day
        after_month
        after_year
        at_or_before
        at_or_before_day
        at_or_before_month
        at_or_before_year
        at_or_after
        at_or_after_day
        at_or_after_month
        at_or_after_year
      ]

      def proxy_methods
        PROXY_METHODS
      end


      # Intervals

      def within(from, to)
        model.where "#{attr} >= ? AND #{attr} <= ?", from.in_time_zone, to.in_time_zone
      end

      def within_days(from, to)
        within from.in_time_zone.beginning_of_day, to.in_time_zone.end_of_day
      end

      def within_months(from, to)
        within from.in_time_zone.beginning_of_month, to.in_time_zone.end_of_month
      end

      def within_years(from, to)
        within from.in_time_zone.beginning_of_year, to.in_time_zone.end_of_year
      end

      # Specific day/month/year

      def at_day(day)     ; within_days day, day       ; end
      def at_month(month) ; within_months month, month ; end
      def at_year(year)   ; within_years year, year    ; end

      # Strict equations

      def before(time)        ; model.where "#{attr} < ?", time.in_time_zone       ; end
      def before_day(day)     ; before day.in_time_zone.beginning_of_day     ; end
      def before_month(month) ; before month.in_time_zone.beginning_of_month ; end
      def before_year(year)   ; before year.in_time_zone.beginning_of_year   ; end

      def after(time)        ; model.where "#{attr} > ?", time.in_time_zone ; end
      def after_day(day)     ; after day.in_time_zone.end_of_day      ; end
      def after_month(month) ; after month.in_time_zone.end_of_month  ; end
      def after_year(year)   ; after year.in_time_zone.end_of_year    ; end

      # Non-strict equations

      def at_or_before(time)        ; model.where "#{attr} <= ?", time.in_time_zone      ; end
      def at_or_before_day(day)     ; at_or_before day.in_time_zone.end_of_day     ; end
      def at_or_before_month(month) ; at_or_before month.in_time_zone.end_of_month ; end
      def at_or_before_year(year)   ; at_or_before year.in_time_zone.end_of_year   ; end

      def at_or_after(time)        ; model.where "#{attr} >= ?", time.in_time_zone           ; end
      def at_or_after_day(day)     ; at_or_after day.in_time_zone.beginning_of_day     ; end
      def at_or_after_month(month) ; at_or_after month.in_time_zone.beginning_of_month ; end
      def at_or_after_year(year)   ; at_or_after year.in_time_zone.beginning_of_year   ; end
    end
  end
end
