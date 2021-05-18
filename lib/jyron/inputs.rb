module JYRon

  module Inputs

    INPUTS_LIST = [:from_rb, :from_json, :from_yaml]
    CLI_INPUTS = {:from_json => {:desc => "Input from JSON File"},
    :from_rb => {:desc => "Input from RB File (Use very CAREFULLY)"},
    :from_yaml => {:desc => "Input from YAML File"}}

    class BadInputFormat < Exception; end



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

    def from_rb(string)
      eval("@object=#{string}")
      adapt
      return self
    end
  end

end
