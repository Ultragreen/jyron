module JYRon

  module Inputs

    INPUTS_LIST = [:from_ron, :from_json, :from_yaml, :from_object]
    CLI_INPUTS = {:from_json => {:desc => "Input from JSON File"},
    :from_yaml => {:desc => "Input from YAML File"}}

    class BadInputFormat < Exception; end

    def from_object(obj)
      @object = obj
      adapt
      return self
    end

    def from_yaml(string)
      begin
        @object = YAML::load(string)
        adapt
        return self
      rescue Psych::SyntaxError
        raise BadInputFormat.new 'Not in YAML format'
      end
    end

    def from_json(string)
      begin
        @object = JSON.parse(string)
        adapt
        return self
      rescue JSON::ParserError
        raise BadInputFormat.new 'Not in JSON format'
      end
    end

    def from_ron(string)
      eval("@object=#{string}")
      adapt
      return self
    end
  end

end
