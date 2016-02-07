require_relative "abstract_proxy"

module DateTimeScopes
  class DateProxy < AbstractProxy
    PROXY_METHODS = %w[
      within_days
      within_months
      within_years
      on_day
      on_month
      on_year
      before_day
      before_month
      before_year
      after_day
      after_month
      after_year
      on_or_before_day
      on_or_before_month
      on_or_before_year
      on_or_after_day
      on_or_after_month
      on_or_after_year
    ].freeze

    def proxy_methods
      PROXY_METHODS
    end

    # Intervals

    def within_days(from, to, time_zone: @time_zone)
      @klass.where(
        "#{@attribute}) >= ? AND #{@attribute} <= ?",
        from.in_time_zone(time_zone).to_date,
        to.in_time_zone(time_zone).to_date
      )
    end

    def within_months(from, to, time_zone: @time_zone)
      within_days(
        from.in_time_zone(time_zone).beginning_of_month,
        to.in_time_zone(time_zone).end_of_month,
        time_zone: time_zone
      )
    end

    def within_years(from, to, time_zone: @time_zone)
      within_days(
        from.in_time_zone(time_zone).beginning_of_year,
        to.in_time_zone(time_zone).end_of_year,
        time_zone: time_zone
      )
    end

    # Specific day/month/year

    def on_day(day, time_zone: @time_zone)     ; within_days day, day, time_zone: time_zone       ; end
    def on_month(month, time_zone: @time_zone) ; within_months month, month, time_zone: time_zone ; end
    def on_year(year, time_zone: @time_zone)   ; within_years year, year, time_zone: time_zone    ; end

    # Strict equations

    def before_day(day, time_zone: @time_zone)     ; @klass.where "#{@attribute} < ?", day.in_time_zone(time_zone).to_date             ; end
    def before_month(month, time_zone: @time_zone) ; before_day month.in_time_zone(time_zone).beginning_of_month, time_zone: time_zone ; end
    def before_year(year, time_zone: @time_zone)   ; before_day year.in_time_zone(time_zone).beginning_of_year, time_zone: time_zone   ; end

    def after_day(day, time_zone: @time_zone)     ; @klass.where "#{@attribute} > ?", day.in_time_zone(time_zone).to_date      ; end
    def after_month(month, time_zone: @time_zone) ; after_day month.in_time_zone(time_zone).end_of_month, time_zone: time_zone ; end
    def after_year(year, time_zone: @time_zone)   ; after_day year.in_time_zone(time_zone).end_of_year, time_zone: time_zone   ; end

    # Non-strict equations

    def on_or_before_day(day, time_zone: @time_zone)     ; @klass.where "#{@attribute} <= ?", day.in_time_zone(time_zone).to_date            ; end
    def on_or_before_month(month, time_zone: @time_zone) ; on_or_before_day month.in_time_zone(time_zone).end_of_month, time_zone: time_zone ; end
    def on_or_before_year(year, time_zone: @time_zone)   ; on_or_before_day year.in_time_zone(time_zone).end_of_year, time_zone: time_zone   ; end

    def on_or_after_day(day, time_zone: @time_zone)     ; @klass.where "#{@attribute} >= ?", day.in_time_zone(time_zone).to_date                 ; end
    def on_or_after_month(month, time_zone: @time_zone) ; on_or_after_day month.in_time_zone(time_zone).beginning_of_month, time_zone: time_zone ; end
    def on_or_after_year(year, time_zone: @time_zone)   ; on_or_after_day year.in_time_zone(time_zone).beginning_of_year, time_zone: time_zone   ; end
  end
end
