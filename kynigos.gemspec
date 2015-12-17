lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "kynigos"
  spec.version       = "0.0.1"
  spec.authors       = ["Vincent"]
  spec.email         = ["vinyoodles@gmail.com"]

  spec.description   = "Gem for finding specific threads in reddit"
  spec.summary       = %q{Find unique threads and links in reddit}
  spec.license       = "MIT"

  spec.files         = ["lib/"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", '~> 4.0'
  spec.add_development_dependency "pry", '~> 0'
  spec.add_development_dependency "snoo", "~>0.1.2"
end
