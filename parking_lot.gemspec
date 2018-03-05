
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "parking_lot/version"

Gem::Specification.new do |spec|
  spec.name          = "parking_lot"
  spec.version       = ParkingLot::VERSION
  spec.authors       = ["Sathishkumar Natesan"]
  spec.email         = ["nnsathish@gmail.com"]

  spec.summary       = %q{Car Parking Lot Manager}
  spec.description   = %q{Manage parking lot using CLI and find info based on slot or car info}
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "http://notallowed.to.push"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '~> 2.4'
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
