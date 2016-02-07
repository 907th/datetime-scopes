require "spec_helper"

RSpec.describe "datetime_scopes" do
  def self.test(method_name, params:, matching:, not_matching:)
    describe "##{method_name}" do
      let!(:method_name) { "foo_#{method_name}" }
      let!(:params) { params }
      let!(:matching) { matching }
      let!(:not_matching) { not_matching }

      before do
        (matching + not_matching).each do |t|
          FooBar.create! foo: t.in_time_zone
        end
      end

      def perform
        FooBar.send method_name, *params
      end

      it "includes matching times" do
        ret = perform.to_a.map(&:foo)
        matching.map(&:in_time_zone).each do |t|
          expect(ret).to include(t)
        end
      end

      it "doesn't include not matching times" do
        ret = perform.to_a.map(&:foo)
        not_matching.map(&:in_time_zone).each do |t|
          expect(ret).not_to include(t)
        end
      end
    end
  end

  test(
    "within",
    params: ["11.01.2015 23:41:35", "12.01.2015 01:00:23"],
    matching: [
      "11.01.2015 23:41:35",
      "12.01.2015 00:40:01",
      "12.01.2015 01:00:23"
    ],
    not_matching: [
      "11.01.2015 23:41:34",
      "12.01.2015 01:00:24"
    ]
  )

  pending "#within_days"
  pending "#within_months"
  pending "#within_years"
  pending "#on_day"
  pending "#on_month"
  pending "#on_year"
  pending "#before"
  pending "#before_day"
  pending "#before_month"
  pending "#before_year"
  pending "#after"
  pending "#after_day"
  pending "#after_month"
  pending "#after_year"
  pending "#on_or_before"
  pending "#on_or_before_day"
  pending "#on_or_before_month"
  pending "#on_or_before_year"
  pending "#on_or_after"
  pending "#on_or_after_day"
  pending "#on_or_after_month"
  pending "#on_or_after_year"
end
