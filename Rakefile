require 'rake'
require 'rake/clean'
require 'rdoc/task'
require 'rspec/core/rake_task'

RDoc::Task.new do |rdoc|
  files = ['README.markdown', 'lib/**/*.rb']
  rdoc.rdoc_files.add(files)
  rdoc.main = 'README.markdown'
  rdoc.title = 'ruby_events Docs'
  rdoc.rdoc_dir = 'doc/rdoc'
  rdoc.options << '--line-numbers'
end

RSpec::Core::RakeTask.new(:spec)

desc 'NXT related tasks'
namespace :nxt do
  desc 'Detect a connected NXT brick within /dev.'
  task :detect do
    unless ENV['NXT'] || ENV['DEV']
      raise "/dev not fount, please ensure you're using a *nix system." unless Dir.exist?('/dev')

      devices = Dir['/dev/*NXT*']
      raise 'Could not detect any connected NXT bricks.' if devices.empty?
      puts "Detected a NXT brick at '#{devices.first}'."
    end
  end
end
