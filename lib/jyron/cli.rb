Dir[File.dirname(__FILE__) + '/cli/*.rb'].each {|file| require file  }

module JYRon
  module CLI
    class Binding < Thor
      include JYRon::Inputs
      include JYRon::Helpers
      desc "mediator", "say hello to NAME"
      long_desc <<-LONGDESC
      Mediator
      LONGDESC
      option :file, :type => :string, :aliases => "-f"
      CLI_INPUTS.each do |input,params|
        option input, :type => :boolean,  :desc => params[:desc]
      end
      def mediator
        components = options.to_h.keys.map(&:to_sym)
        if options[:file] then
          begin
            data = readfile(options[:file])
          rescue HelpersError => e
            puts "#{e}"
            exit 1
          end
        else
          puts "A data file is required ( --file|-f <filename> )"
          exit 2
        end
        test = JYRon::Mediator::new adapters: [:stringify_keys, :camelcase_keys]
        inputs = components.select{|value| value =~ /^from/} & CLI_INPUTS.keys
        unless inputs.size < 2 then
          puts "Only one inputs type requiered"
          exit 2
        end
        if inputs.empty? then
          puts "Inputs type requiered (--from-<type>)"
          exit 3
        end

        input = inputs.first
        begin
          test.send(input, data)
        rescue BadInputFormat => e
          puts "Bad Input format : #{e}"
          exit 4
        end

        puts test.to_json

      end
    end
  end
end
