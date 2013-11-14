Gem::Specification.new do |s|
  s.name                    = 'databag_version'
  s.version                 = '1.1.0'
  s.summary                 = "Create versioned data bag items"
  s.description             = "Processes data bag item templates with Erubis & thor-scmversion to create 'versioned' data bag items."
  s.authors                 = ["Kristian Van Der Vliet"]
  s.email                   = 'kvandervliet@dyn.com'
  s.homepage                = 'https://github.corp.dyndns.com/kvandervliet/databag-version'
  s.files                   = ["lib/databag_version.rb"]
  s.executables             << 'version-databags'
  s.add_runtime_dependency  'thor-scmversion'
  s.license                 = 'Apache-2.0'
end
