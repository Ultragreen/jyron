Dir[File.dirname(__FILE__) + '/cli/*.rb'].each {|file| require file  }

module JYRon
  module CLI
    class CMDBinding < Thor
      include JYRon::Inputs
      include JYRon::Outputs
      include JYRon::Filters
      include JYRon::Helpers
      include JYRon::Adapters
      include JYRon::CLI::Exiter
      desc "mediator", "say hello to NAME"
      long_desc <<-LONGDESC
      Mediator
      LONGDESC
      option :adapters, :type => :string, :banner => "<ADAPTER, ...>", :desc => "List of Adapters"
      option :file, :type => :string, :aliases => "-f", :banner => "<FILENAME>", :desc => "Input filename"
      CLI_INPUTS.each do |input,params|
        option input, :type => :boolean,  :desc => params[:desc], :negate => false
      end
      CLI_OUTPUTS.each do |output,params|
        option output, :type => :boolean,  :desc => params[:desc], :negate => false
      end
      FILTERS.each do |filter,params|
        option "filter-#{filter}".to_sym, :type => :string,  :desc => params[:desc], :negate => false, :banner => params[:banner]
      end
      def mediator
        components = options.to_h.keys.map(&:to_sym)
        if options[:file] then
          begin
            data = readfile(options[:file])
          rescue HelpersError => e
            cli_exit case: :not_found, more: e
          end
        elsif $stdin.ready?
          data = STDIN.read
        else
          cli_exit case: :option_needed, more: "Data from STDIN or file ( --file|-f <filename> )"
        end

        #Adapters
        adapters = []
        adapters = options[:adapters].split(',').map(&:to_sym) if options[:adapters]
        invalid_adapters = []
        adapters.each {|adapter| invalid_adapters.push adapter unless ADAPTERS.include? adapter }
        cli_exit case: :configuration_error, more: "Adapter(s) : #{invalid_adapters.join(', ')} not found" unless invalid_adapters.empty?

        data_pipe = JYRon::Mediator::new adapters: adapters

        # inputs
        inputs = components.select{|value| value =~ /^from/} & CLI_INPUTS.keys
        cli_exit case: :options_incompatibility, more: "Only one inputs type requiered" unless inputs.size < 2
        cli_exit case: :option_needed, more: "Inputs type requiered (--from-<type>)" if inputs.empty?
        input = inputs.first
        begin
          data_pipe.send(input, data)
        rescue BadInputFormat => e
          cli_exit case: :status_ko, more: "Bad Input format : #{e}"
        end

        # filters
        filters = components.select{|value| value =~ /^filter/}
        filters.each do |filter|
          meth = filter.to_s.gsub('filter-','')
          data_pipe.send meth.to_sym, options[filter]
        end

        # outputs
        outputs = components.select{|value| value =~ /^to/} & CLI_OUTPUTS.keys
        cli_exit case: :options_incompatibility, more: "Only one outputs type requiered" unless outputs.size < 2
        cli_exit case: :option_needed, more: "Outputs type requiered (--to-<type>)" if outputs.empty?
        output = outputs.first
        puts data_pipe.send output

      end

      def self.exit_on_failure?
        true
      end

    end
  end
end
