module JYRon
  module Filters
    def jsonpath!(expression)
      if @adapters.include? :symbolyse then
        res = JsonPath.new(expression, use_symbols: true).on(@object)
      else
        res = JsonPath.new(expression).on(@object)
      end
      @object = res
      return self
    end
  end
end
