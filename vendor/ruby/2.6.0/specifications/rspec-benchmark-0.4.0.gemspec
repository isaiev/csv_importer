# -*- encoding: utf-8 -*-
# stub: rspec-benchmark 0.4.0 ruby lib

Gem::Specification.new do |s|
  s.name = "rspec-benchmark".freeze
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Piotr Murach".freeze]
  s.date = "2018-10-01"
  s.description = "Performance testing matchers for RSpec that provide simple way to specify speed and algorithmic complexity benchmark expectations".freeze
  s.email = ["".freeze]
  s.homepage = "".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0".freeze)
  s.rubygems_version = "3.0.1".freeze
  s.summary = "Performance testing matchers for RSpec".freeze

  s.installed_by_version = "3.0.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<benchmark-perf>.freeze, ["~> 0.4.0"])
      s.add_runtime_dependency(%q<benchmark-trend>.freeze, ["~> 0.2.0"])
      s.add_runtime_dependency(%q<rspec>.freeze, [">= 3.0.0", "< 4.0.0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.16"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
    else
      s.add_dependency(%q<benchmark-perf>.freeze, ["~> 0.4.0"])
      s.add_dependency(%q<benchmark-trend>.freeze, ["~> 0.2.0"])
      s.add_dependency(%q<rspec>.freeze, [">= 3.0.0", "< 4.0.0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.16"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    end
  else
    s.add_dependency(%q<benchmark-perf>.freeze, ["~> 0.4.0"])
    s.add_dependency(%q<benchmark-trend>.freeze, ["~> 0.2.0"])
    s.add_dependency(%q<rspec>.freeze, [">= 3.0.0", "< 4.0.0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.16"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
  end
end
