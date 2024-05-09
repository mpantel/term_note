# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'term_note'
  s.version     = '0.0.3'
  s.date        = '2024-05-08'
  s.summary     = "Give presentations written in Ruby through plain old console"
  s.description = "Write simple in terminal presentations which include: presentation slides, executable slides and tests execution code in Ruby"
  s.authors     = ["Michail Pantelelis"]
  s.email       = 'mpantel@aegean.gr'
  s.files       = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(tmp|doc|test|spec|features|.gitignore|samples)/}) }
  s.homepage    = 'https://rubygems.org/gems/term_note'
  s.license     = 'MIT'
  s.require_paths = ["lib"]

  s.add_dependency 'minitest'
  s.add_dependency 'method_source'
  s.add_dependency 'colorize'
  s.add_dependency 'rmagick'
  s.add_dependency 'capybara'
  s.add_dependency 'webdrivers'

end
