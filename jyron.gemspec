Gem::Specification.new do |s|
  s.name = %q{jyron}
  s.author = "Romain GEORGES"
  s.version = "0.1"
  s.date = "2021-05-14"
  s.summary = "JYRon : JSON YAML Ruby object notation"
  s.email = "romain@ultragreen.net"
  s.homepage = "https://github.com/Ultragreen/jyron"
  s.description = "JYRon : provide facilities to maniplate, convert, querying, storing transportables objects"
  s.files = `git ls-files`.split($/)
  s.require_paths = ["lib"]
  s.require_paths << 'bin'
  s.bindir = 'bin'
  s.executables = Dir["bin/*"].map!{|item| item.gsub("bin/","")}
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.add_runtime_dependency 'thor','~> 1.1.0'
  s.add_runtime_dependency 'mime-types','~> 3.3.1'
  s.add_runtime_dependency 'jsonpath','~> 1.1.0'
  s.add_runtime_dependency 'activesupport','~> 6.1.3.2'
  s.add_development_dependency 'rake', '~> 13.0.1'
  s.add_development_dependency 'rspec', '~> 3.9.0'
  s.add_development_dependency 'yard', '~> 0.9.24'
  s.add_development_dependency 'rdoc', '~> 6.2.1'
  s.add_development_dependency 'roodi', '~> 5.0.0'
  s.add_development_dependency 'code_statistics', '~> 0.2.13'
  s.add_development_dependency 'yard-rspec', '~> 0.1'
  s.license = "BSD-2-Clause"
end
