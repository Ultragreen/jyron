module JYRon
  class Mediator
    attr_accessor :object
    include JYRon::Adapters
    include JYRon::Filters
    include JYRon::Outputs
    include JYRon::Inputs

    def initialize(options = {})
      @object = options[:from_object] if options[:from_object]
      from_yaml(options[:from_yaml]) if options[:from_yaml]
      from_json(options[:from_json]) if options[:from_json]
      @adapters = []
      @adapters.push(options[:adapters]).flatten! if options[:adapters]
      adapt unless @object.nil?
    end







    private
    def adapt
      @adapters.each do |adapter|
        self.send adapter
      end
    end



  end
end
