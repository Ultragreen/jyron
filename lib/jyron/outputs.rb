module JYRon
  module Outputs
    def to_ron
      res = @object.pretty_inspect
      return res
    end

    def to_json

      return JSON.pretty_generate(@object)
    end

    def to_yaml
      return @object.to_yaml
    end

    def to_obj
      return @object
    end
    

  end
end
