module JYRon
  module Outputs


    OUTPUTS_LIST = [:to_rb, :to_json, :to_yaml]
    CLI_OUTPUTS = {:to_json => {:desc => "JSON Output format"},
    :to_yaml => {:desc => "YAML Output format"},
    :to_rb => {:desc => "RB/RON (Ruby Object Notation) Output format, use with carefull !"},
     }

    def to_rb
      res = @object.pretty_inspect
      return res
    end

    def to_json

      return JSON.pretty_generate(@object).concat("\n")
    end

    def to_yaml
      return @object.to_yaml
    end




  end
end
