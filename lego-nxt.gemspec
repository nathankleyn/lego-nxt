Gem::Specification.new do |spec|
  spec.name = 'lego-nxt'
  spec.version = '0.2.0'
  spec.extra_rdoc_files = ['README.md']
  spec.summary = 'Ruby LEGO Mindstorms NXT 2.0 control via Bluetooth and USB.'
  spec.description = spec.summary + ' See http://github.com/nathankleyn/lego-nxt for more information.'
  spec.author = 'Nathan Kleyn'
  spec.email = 'nathan@nathankleyn.com'
  spec.homepage = 'http://github.com/nathankleyn/lego-nxt'
  spec.files = %w(README.markdown Rakefile) + Dir.glob('{lib,spec}/**/*')
  spec.require_path = 'lib'

  spec.add_dependency('serialport', '~>1.1.0')
  spec.add_dependency('activesupport', '~>3.2.13')
  spec.add_dependency('libusb', '~>0.3.4')
  spec.add_development_dependency('rspec', '~>2.13.0')
  spec.add_development_dependency('pry', '~>0.9.12.2')
  spec.add_development_dependency('yard', '~>0.8.6.1')
  spec.add_development_dependency('redcarpet', '~>2.3.0')
end
