module JYRon
class CLI < Thor
  include JYRon::Inputs
  include JYRon
  desc "mediator", "say hello to NAME"
  long_desc <<-LONGDESC
    Mediator
  LONGDESC
  option :file, :type => :string, :aliases => "-f"
  CLI_INPUTS.each do |input,params|
    option input, :type => :string, :banner => params.banner,  :desc = > params.desc
  end
  def mediator
    if options[:file] then
      data = readfile(options[:file])
    else
      puts "A data file is required ( --file|-f <filename> )"
      exit 2
    end
    test = JYRon::Mediator::new adapters: [:stringify_keys, :camelcase_keys]
    inputs = options.select{|value| value.to_s =~ /^from_/} & CLI_INPUTS.keys
    unless inputs.size < 2 then
      puts "Only one inputs type requiered"
      exit 2
    end
    input = inputs.first
    puts test.send(input, data).jsonpath!("$..Maths").to_json
  end
end

end
