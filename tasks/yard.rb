require 'yard'

YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb']
  t.options = [
    '--protected',
    '--files', 'History.txt',
    '--title', 'ruby-nikto',
    '--quiet'
  ]
end

task :docs => :yardoc
