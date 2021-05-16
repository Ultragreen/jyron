module JYRon
  module Inputs
    def from_object (obj)
      @object = obj
      adapt
      return self
    end

    def from_yaml(string)
      @object = YAML::load(string)
      adapt
      return self
    end

    def from_json(string)
      @object = JSON.parse(string)
      adapt
      return self
    end

    def from_ron(string)
      eval("@object=#{string}")
      adapt
      return self
    end
  end

end
