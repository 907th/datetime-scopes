require "spec_helper"

RSpec.describe FooBar do
  describe "::datetime_scopes" do
    let!(:proxy_methods) { DateTimeScopes::DateTimeProxy::PROXY_METHODS }

    it "defines datetime scopes" do
      proxy_methods.each do |method_name|
        expect(FooBar).to respond_to "foo_#{method_name}"
      end
    end

    it "delegates a scope call to a proxy" do
      proxy_methods.each do |method_name|
        dbl = double("result")
        expect_any_instance_of(DateTimeScopes::DateTimeProxy).to receive(method_name).with(FooBar, 1, 2, 3).and_return(dbl)
        res = FooBar.send("foo_#{method_name}", 1, 2, 3)
        expect(res).to eq(dbl)
      end
    end
  end

  describe "::date_scopes" do
    def proxy_methods
      DateTimeScopes::DateProxy::PROXY_METHODS
    end

    it "defines date scopes" do
      proxy_methods.each do |method_name|
        expect(FooBar).to respond_to "bar_#{method_name}"
      end
    end

    it "delegates a scope call to a proxy" do
      proxy_methods.each do |method_name|
        dbl = double("result")
        expect_any_instance_of(DateTimeScopes::DateProxy).to receive(method_name).with(FooBar, 1, 2, 3).and_return(dbl)
        res = FooBar.send("bar_#{method_name}", 1, 2, 3)
        expect(res).to eq(dbl)
      end
    end
  end
end
