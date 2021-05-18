require_relative '../lib/jyron'

RSpec.configure do |config|
  config.formatter = :documentation

end
RSpec::Expectations.configuration.on_potential_false_positives = :nothing


describe JYRon::Mediator do
  $data = {}
  $data[:from_yaml] = {:content => File::readlines("./spec/test.yml").join, :type => 'yaml'}
  $data[:from_json] = {:content => File::readlines("./spec/test.json").join, :type => 'json'}
  $data[:from_rb] = {:content => File::readlines("./spec/test.rb").join, :type => 'rb'}
  $data[:from_obj] = {:content => { 'Key' => "value", "Node" => { 'Key1' => 'value1', 'Key2' => 'value2'}}, :type => 'obj'}

  before :all do

  end

  after :all do

  end

  subject { JYRon::Mediator::new }
  specify { should be_an_instance_of JYRon::Mediator }
  context "Inputs" do

    $data.keys.each do |input|
      describe "##{input} with #{$data[input][:type]}" do
        specify { expect(subject).to respond_to input }
        specify { expect(subject.send input, $data[input][:content]).to be_an_instance_of JYRon::Mediator }
        specify { expect{subject.send input, $data[input][:content]}.to_not raise_error(JYRon::Inputs::BadInputFormat) }
      end

    end
  end
  context "Outputs" do
    describe "#to_json" do
      specify { expect(subject).to respond_to :to_json }
      specify { expect(subject.to_json).to be_an_instance_of String }
      specify { expect(subject.from_yaml($data[:from_yaml][:content]).to_json).to eq $data[:from_json][:content]}
    end
    describe "#to_yaml" do
      specify { expect(subject).to respond_to :to_yaml }
      specify { expect(subject.to_yaml).to be_an_instance_of String }
      specify { expect(subject.from_json($data[:from_json][:content]).to_yaml).to eq $data[:from_yaml][:content]}
    end
    describe "#to_rb" do
      specify { expect(subject).to respond_to :to_rb }
      specify { expect(subject.to_rb).to be_an_instance_of String }
      specify { expect(subject.from_json($data[:from_json][:content]).to_rb).to eq $data[:from_rb][:content]}
    end
  end

  context "Filters" do
    describe "#jsonpath with expression $..Node" do
      specify { expect(subject).to respond_to :jsonpath }
      specify { expect(subject.from_json($data[:from_json][:content]).jsonpath("$..Node")).to be_an_instance_of JYRon::Mediator }
      specify { expect(subject.from_json($data[:from_json][:content]).jsonpath("$..Node").to_obj).to eq([{ 'Key1' => 'value1', 'Key2' => 'value2'}]) }
    end
  end

end
