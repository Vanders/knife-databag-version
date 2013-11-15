# encoding: utf-8

Gem::Specification.new do |g|
  g.name                    = 'knife-data-bag-version'
  g.version                 = IO.read(File.join(File.dirname(__FILE__), "VERSION")) rescue "0.0.1"
  g.summary                 = "Create versioned data bag items"
  g.description             = "Processes data bag item templates with Erubis & thor-scmversion to create 'versioned' data bag items."
  g.authors                 = ["Kristian Van Der Vliet"]
  g.email                   = 'kvandervliet@dyn.com'
  g.homepage                = ''
  g.license                 = 'Apache-2.0'

  g.files                   = `git ls-files`.split($\)
  g.executables             = g.files.grep(%r{^bin/}).map{ |f| File.basename(f) }

  g.add_runtime_dependency  'thor-scmversion'
end
