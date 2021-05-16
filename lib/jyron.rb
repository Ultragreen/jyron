
require 'requierements'

module JYRon
  include JYRon::Mediator
end

data = File::readlines("./spec/test.json").join("\n")
test = JYRon::Mediator::new adapters: [:stringify_keys, :camelcase_keys]
puts test.from_json(data).jsonpath!("$..Maths").to_json
