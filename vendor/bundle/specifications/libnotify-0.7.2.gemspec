# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "libnotify"
  s.version = "0.7.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Peter Suschlik"]
  s.date = "2012-01-18"
  s.email = ["peter-libnotify@suschlik.de"]
  s.homepage = "http://rubygems.org/gems/libnotify"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.15"
  s.summary = "Ruby bindings for libnotify using FFI"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ffi>, ["~> 1.0.0"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
      s.add_development_dependency(%q<minitest-libnotify>, [">= 0"])
      s.add_development_dependency(%q<yard>, ["~> 0.7.0"])
    else
      s.add_dependency(%q<ffi>, ["~> 1.0.0"])
      s.add_dependency(%q<minitest>, [">= 0"])
      s.add_dependency(%q<minitest-libnotify>, [">= 0"])
      s.add_dependency(%q<yard>, ["~> 0.7.0"])
    end
  else
    s.add_dependency(%q<ffi>, ["~> 1.0.0"])
    s.add_dependency(%q<minitest>, [">= 0"])
    s.add_dependency(%q<minitest-libnotify>, [">= 0"])
    s.add_dependency(%q<yard>, ["~> 0.7.0"])
  end
end
