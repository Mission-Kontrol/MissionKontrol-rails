# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mission_kontrol_relay/version'

Gem::Specification.new do |spec|
  spec.name          = 'mission_kontrol_relay'
  spec.version       = MissionKontrolRelay::VERSION
  spec.authors       = ['Camilla van Klinken']
  spec.email         = ['camillavk@gmail.com']

  spec.summary       = 'Official Rails gem for MissionKontrol'
  spec.description   = 'https://MissionKontrol.io is a simple and effective admin interface for your applications or microservices.'
  spec.homepage      = 'https://github.com/Mission-Kontrol/MissionKontrol-rails'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'rake', '>= 12.3.3'
  spec.add_development_dependency 'sqlite3'
  spec.add_dependency 'rails', '~> 5.1'
end
