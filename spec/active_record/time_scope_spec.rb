require "spec_helper"

RSpec.describe ActiveRecord::TimeScope do
  describe "::time_scope" do
    subject {
      create_tmp_model foo_at: :datetime do
        time_scope :foo_at
      end
    }

    let(:scope_names) { %w[
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
    ] }

    it "defines time scopes on the attribute" do
      scope_names.each do |scope_name|
        is_expected.to respond_to "foo_#{scope_name}"
      end
    end

    it "delegates time scope calls to the proxy object" do
      scope_names.each do |scope_name|
        expect_any_instance_of(ActiveRecord::TimeScope::TimeProxy).to receive(scope_name).with(1, 2, 3)
        subject.send "foo_#{scope_name}", 1, 2, 3
      end
    end
  end

  describe "::date_scope" do
    subject {
      create_tmp_model foo_at: :date do
        date_scope :foo_at
      end
    }

    let(:scope_names) { %w[
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
    ] }

    it "defines date scopes on the attribute" do
      scope_names.each do |scope_name|
        is_expected.to respond_to "foo_#{scope_name}"
      end
    end

    it "delegates date scope calls to the proxy object" do
      scope_names.each do |scope_name|
        expect_any_instance_of(ActiveRecord::TimeScope::DateProxy).to receive(scope_name).with(1, 2, 3)
        subject.send "foo_#{scope_name}", 1, 2, 3
      end
    end
  end
end
