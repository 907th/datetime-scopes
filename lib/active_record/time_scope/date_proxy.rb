require "active_record/time_scope/abstract_proxy"

module ActiveRecord
  module TimeScope
    class DateProxy < AbstractProxy
      PROXY_METHODS = %w[
        within_days
        within_months
        within_years
        at_day
        at_month
        at_year
        before_day
        before_month
        before_year
        after_day
        after_month
        after_year
        at_or_before_day
        at_or_before_month
        at_or_before_year
        at_or_after_day
        at_or_after_month
        at_or_after_year
      ]

      def proxy_methods
        PROXY_METHODS
      end


      # Intervals

      def within_days(from, to)
        model.where "#{attr} >= ? AND #{attr} <= ?", from.in_time_zone.to_date, to.in_time_zone.to_date
      end

      def within_months(from, to)
        within_days from.in_time_zone.beginning_of_month, to.in_time_zone.end_of_month
      end

      def within_years(from, to)
        within_days from.in_time_zone.beginning_of_year, to.in_time_zone.end_of_year
      end

      # Specific day/month/year

      def at_day(day)     ; within_days day, day       ; end
      def at_month(month) ; within_months month, month ; end
      def at_year(year)   ; within_years year, year    ; end

      # Strict equations

      def before_day(day)     ; model.where "#{attr} < ?", day.in_time_zone.to_date    ; end
      def before_month(month) ; before_day month.in_time_zone.beginning_of_month ; end
      def before_year(year)   ; before_day year.in_time_zone.beginning_of_year   ; end

      def after_day(day)     ; model.where "#{attr} > ?", day.in_time_zone.to_date ; end
      def after_month(month) ; after_day month.in_time_zone.end_of_month     ; end
      def after_year(year)   ; after_day year.in_time_zone.end_of_year       ; end

      # Non-strict equations

      def at_or_before_day(day)     ; model.where "#{attr} <= ?", day.in_time_zone.to_date   ; end
      def at_or_before_month(month) ; at_or_before_day month.in_time_zone.end_of_month ; end
      def at_or_before_year(year)   ; at_or_before_day year.in_time_zone.end_of_year   ; end

      def at_or_after_day(day)     ; model.where "#{attr} >= ?", day.in_time_zone.to_date        ; end
      def at_or_after_month(month) ; at_or_after_day month.in_time_zone.beginning_of_month ; end
      def at_or_after_year(year)   ; at_or_after_day year.in_time_zone.beginning_of_year   ; end
    end
  end
end
