require_relative "abstract_proxy"

module DateTimeScopes
  class DateTimeProxy < AbstractProxy
    PROXY_METHODS = %w[
      within
      within_days
      within_months
      within_years
      on_day
      on_month
      on_year
      before
      before_day
      before_month
      before_year
      after
      after_day
      after_month
      after_year
      on_or_before
      on_or_before_day
      on_or_before_month
      on_or_before_year
      on_or_after
      on_or_after_day
      on_or_after_month
      on_or_after_year
    ].freeze

    def proxy_methods
      PROXY_METHODS
    end

    # Intervals

    def within(from, to, time_zone: @time_zone)
      @klass.where(
        "#{@attribute} >= ? AND #{@attribute} <= ?",
        from.in_time_zone(time_zone),
        to.in_time_zone(time_zone)
      )
    end

    def within_days(from, to, time_zone: @time_zone)
      within(
        from.in_time_zone(time_zone).beginning_of_day,
        to.in_time_zone(time_zone).end_of_day,
        time_zone: time_zone
      )
    end

    def within_months(from, to, time_zone: @time_zone)
      within(
        from.in_time_zone(time_zone).beginning_of_month,
        to.in_time_zone(time_zone).end_of_month,
        time_zone: time_zone
      )
    end

    def within_years(from, to, time_zone: @time_zone)
      within(
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

    def before(time, time_zone: @time_zone)        ; @klass.where "#{@attribute} < ?", time.in_time_zone(time_zone)                ; end
    def before_day(day, time_zone: @time_zone)     ; before day.in_time_zone(time_zone).beginning_of_day, time_zone: time_zone     ; end
    def before_month(month, time_zone: @time_zone) ; before month.in_time_zone(time_zone).beginning_of_month, time_zone: time_zone ; end
    def before_year(year, time_zone: @time_zone)   ; before year.in_time_zone(time_zone).beginning_of_year, time_zone: time_zone   ; end

    def after(time, time_zone: @time_zone)        ; @klass.where "#{@attribute} > ?", time.in_time_zone(time_zone)                ; end
    def after_day(day, time_zone: @time_zone)     ; after day.in_time_zone(time_zone).end_of_day, time_zone: time_zone            ; end
    def after_month(month, time_zone: @time_zone) ; after month.in_time_zone(time_zone).end_of_month, time_zone: time_zone        ; end
    def after_year(year, time_zone: @time_zone)   ; after year.in_time_zone(time_zone).end_of_year, time_zone: time_zone          ; end

    # Non-strict equations

    def on_or_before(time, time_zone: @time_zone)        ; @klass.where "#{@attribute} <= ?", time.in_time_zone(time_zone)                ; end
    def on_or_before_day(day, time_zone: @time_zone)     ; on_or_before day.in_time_zone(time_zone).end_of_day, time_zone: time_zone      ; end
    def on_or_before_month(month, time_zone: @time_zone) ; on_or_before month.in_time_zone(time_zone).end_of_month, time_zone: time_zone  ; end
    def on_or_before_year(year, time_zone: @time_zone)   ; on_or_before year.in_time_zone(time_zone).end_of_year, time_zone: time_zone    ; end

    def on_or_after(time, time_zone: @time_zone)        ; @klass.where "#{@attribute} >= ?", time.in_time_zone(time_zone)                    ; end
    def on_or_after_day(day, time_zone: @time_zone)     ; on_or_after day.in_time_zone(time_zone).beginning_of_day, time_zone: time_zone     ; end
    def on_or_after_month(month, time_zone: @time_zone) ; on_or_after month.in_time_zone(time_zone).beginning_of_month, time_zone: time_zone ; end
    def on_or_after_year(year, time_zone: @time_zone)   ; on_or_after year.in_time_zone(time_zone).beginning_of_year, time_zone: time_zone   ; end
  end
end
