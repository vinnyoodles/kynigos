lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "kynigos"
  spec.version       = "1.0.0"
  spec.authors       = ["Vincent Le"]
  spec.email         = ["vinyoodles@gmail.com"]
  spec.description   = "Gem for finding specific threads in reddit"
  spec.summary       = %q{Reddit search bot}
  spec.homepage      = "https://github.com/vinnyoodles/kynigos"
  spec.license       = "MIT"
  spec.files         = ["lib/kynigos.rb"]
  spec.required_ruby_version = '>= 2.2.4'

  spec.add_runtime_dependency 'rake', '~> 10.5', '>= 10.5.0'
end
