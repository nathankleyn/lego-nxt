Gem::Specification.new do |gem|
  gem.name = 'lego-nxt'
  gem.version = '0.2.0'
  gem.extra_rdoc_files = ['README.md']
  gem.summary = 'Ruby LEGO Mindstorms NXT 2.0 control via Bluetooth and USB.'
  gem.description = gem.summary + ' See http://github.com/nathankleyn/lego-nxt for more information.'
  gem.license = 'MIT'
  gem.author = 'Nathan Kleyn'
  gem.email = 'nathan@nathankleyn.com'
  gem.homepage = 'http://github.com/nathankleyn/lego-nxt'
  gem.files = %w[README.md Rakefile] + Dir.glob('{lib,spec}/**/*')
  gem.require_path = 'lib'

  gem.add_dependency 'activesupport', '>=5.2.1', '<6.1.0'
  gem.add_dependency 'libusb', '~>0.6.4'
  gem.add_dependency 'serialport', '~>1.3.1'
  gem.add_development_dependency 'coveralls', '~> 0.8.22'
  gem.add_development_dependency 'filewatcher', '~> 1.0.1'
  gem.add_development_dependency 'pry-byebug', '~> 3.6.0'
  gem.add_development_dependency 'redcarpet', '~> 3.4.0'
  gem.add_development_dependency 'rspec', '~> 3.8.0'
  gem.add_development_dependency 'rubocop', '~> 0.58.2'
  gem.add_development_dependency 'rubocop-rspec', '~> 1.29.0'
  gem.add_development_dependency 'yard', '~> 0.9.16'
end
