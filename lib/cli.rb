module JYRon
class CLI < Thor
  desc "mediator", "say hello to NAME"
  long_desc <<-LONGDESC
    Mediator
  LONGDESC
  option :file, :type => :string, :aliases => "-f"
  option :from_json, :type => :string
  option :from_yaml, :type => :string
  def mediator
    data = File::readlines("./spec/test.json").join("\n")
    test = JYRon::Mediator::new adapters: [:stringify_keys, :camelcase_keys]
    puts test.from_json(data).jsonpath!("$..Maths").to_json
  end
end

end
