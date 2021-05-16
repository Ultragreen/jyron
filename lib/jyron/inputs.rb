module JYRon





  module Inputs





    INPUTS_LIST = [:from_ron, :from_json, :from_yaml, :from_object]
    CLI_INPUTS = {:from_json => {:desc => "Input from JSON File", :banner => "<JSON FILE>"},
                  :from_yaml => {:desc => "Input from YAML File", :banner => "<YAML FILE>"}}




    def from_object(obj)
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
