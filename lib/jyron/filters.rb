module JYRon
  module Filters

    FILTERS = {:jsonpath => {:desc => "Filtering with JSONPath", :banner => "<JSONPath expression"}}

    def jsonpath(expression)
      if @adapters.include? :symbolize_keys then
        res = JsonPath.new(expression, use_symbols: true).on(@object)
      else
        res = JsonPath.new(expression).on(@object)
      end
      @object = res
      return self
    end
  end
end
