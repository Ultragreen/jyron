module JYRon
class CLI < Thor
  include JYRon::Inputs
  desc "mediator", "say hello to NAME"
  long_desc <<-LONGDESC
    Mediator
  LONGDESC
  option :file, :type => :string, :aliases => "-f"
  CLI_INPUTS.each do |input,params|
    option input, :type => :string, :banner => params.banner,  :desc = > params.desc
  end
  def mediator
    data = File::readlines("./spec/test.json").join("\n")
    test = JYRon::Mediator::new adapters: [:stringify_keys, :camelcase_keys]
    puts test.from_json(data).jsonpath!("$..Maths").to_json
  end
end

end
