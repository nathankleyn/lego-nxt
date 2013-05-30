Gem::Specification.new do |spec|
  spec.name = 'nxt'
  spec.version = '0.1.1'
  spec.extra_rdoc_files = ['README.markdown']
  spec.summary = ''
  spec.description = spec.summary + ' See http://github.com/nathankleyn/nxt for more information.'
  spec.author = 'Nathan Kleyn'
  spec.email = 'nathan@unfinitydesign.com'
  spec.homepage = 'http://github.com/nathankleyn/nxt'
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
