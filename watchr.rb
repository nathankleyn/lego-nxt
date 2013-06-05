watch('spec/.*_spec\.rb') { |md| system("rspec #{md[0]}") }
watch('lib/(.*)\.rb') { |md| system("rspec spec/#{md[1]}_spec.rb") }