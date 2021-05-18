module JYRon
  class Mediator
    attr_accessor :object
    include JYRon::Adapters
    include JYRon::Filters
    include JYRon::Outputs
    include JYRon::Inputs

    class MediatorOptionsFailure < Exception; end

    def initialize(options = {})
      @adapters = []
      if options[:adapters] then
        @adapters.push(options[:adapters]).flatten! if options[:adapters]
        options.delete(:adapters)
      end
      from = INPUTS_LIST & options.keys
      raise MediatorOptionsFailure if from.size > 2
      self.send from.first, options[from.first] if from.size == 1
      adapt unless @object.nil?
    end



    def from_obj(obj)
      @object = obj
      adapt
      return self
    end


    def to_obj
      return @object
    end


    private
    def adapt
      @adapters.each do |adapter|
        self.send adapter
      end
    end



  end
end
