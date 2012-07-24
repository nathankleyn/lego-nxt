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
    unless $DEV ||= ENV['NXT'] || ENV['DEV']
      begin
        devices = Dir['/dev/*NXT*']
        if devices.size > 0
          $DEV = devices[0]
          puts "Detected a NXT brick at '#{$DEV}'."
        else
          puts 'Could not detect any connected NXT bricks.'
        end
      rescue
        # FIXME: The /dev directory isn't there, possibly running on Windows.
      end
    end
  end
end
