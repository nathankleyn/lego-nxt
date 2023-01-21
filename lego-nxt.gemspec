# frozen_string_literal: true

Gem::Specification.new do |gem|
  gem.name = 'lego-nxt'

  # If current commit is tagged, that will be our version.
  # Otherwise we'll get some suffixed version, eg. 1.1.2-1-g0fc2ecd
  # Which represents a "distance" we are away from the last tag.
  #
  # Notice we tag as 'v1.2.3' but the gemspec expects just '1.2.3' so
  # we have to strip the prefix.
  gem.version = `git describe --tags`.chomp.delete_prefix('v')
  gem.extra_rdoc_files = ['README.md']
  gem.summary = 'Ruby LEGO Mindstorms NXT 2.0 control via Bluetooth and USB.'
  gem.description = "#{gem.summary} See http://github.com/nathankleyn/lego-nxt for more information."
  gem.license = 'MIT'
  gem.author = 'Nathan Kleyn'
  gem.email = 'nathan@nathankleyn.com'
  gem.homepage = 'http://github.com/nathankleyn/lego-nxt'
  gem.files = %w[README.md Rakefile] + Dir.glob('{lib,spec}/**/*')
  gem.require_path = 'lib'

  gem.required_ruby_version = '>= 2.7.2'

  gem.add_dependency 'activesupport', '>= 6.0.3.4', '< 8'
  gem.add_dependency 'libusb', '~>0.6.4'
  gem.add_dependency 'serialport', '~>1.3.1'

  gem.add_development_dependency 'filewatcher', '~> 1.1', '>= 1.1.1'
  gem.add_development_dependency 'pry-byebug', '~> 3.9', '>= 3.9.0'
  gem.add_development_dependency 'redcarpet', '~> 3.5', '>= 3.5.0'
  gem.add_development_dependency 'rspec', '~> 3.10', '>= 3.10.0'
  gem.add_development_dependency 'rubocop', '~> 1.4', '>= 1.4.2'
  gem.add_development_dependency 'rubocop-rspec', '~> 2.0', '>= 2.0.0'
  gem.add_development_dependency 'simplecov', '~> 0.20', '>= 0.20.0'
  gem.add_development_dependency 'simplecov-lcov', '~> 0.8', '>= 0.8.0'
  gem.add_development_dependency 'yard', '~> 0.9', '>= 0.9.25'
end
