Gem::Specification.new do |spec|
  spec.name = "nxt"
  spec.version = "0.1.0"
  spec.extra_rdoc_files = ["README.markdown"]
  spec.summary = ""
  spec.description = spec.summary + " See http://github.com/nathankleyn/nxt for more information."
  spec.author = "Nathan Kleyn"
  spec.email = "nathan@unfinitydesign.com"
  spec.homepage = "http://github.com/nathankleyn/nxt"
  spec.files = %w(README.markdown Rakefile) + Dir.glob("{lib,spec}/**/*")
  spec.require_path = "lib"

  spec.add_dependency("serialport", "~>1.0.4")
  spec.add_dependency("activesupport", "~>3.2.2")
  spec.add_dependency("ruby-usb", "~>0.2.1")
  spec.add_development_dependency("rspec", "~>2.8.0")
  spec.add_development_dependency("pry", "~>0.9.8.4")
  spec.add_development_dependency("yard", "~>0.7.5")
  spec.add_development_dependency("redcarpet", "~>2.1.0")
end
