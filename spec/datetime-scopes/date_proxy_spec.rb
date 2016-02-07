require "spec_helper"

RSpec.describe DateTimeScopes::DateProxy do
  subject { described_class.new klass: FooBar, attribute: "bar", time_zone: "Moscow" }

  pending "TODO"
end
