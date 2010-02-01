# -*- ruby -*-

require 'rubygems'
require 'hoe'
require 'hoe/signing'

Hoe.plugin :yard

Hoe.spec 'ruby-nikto' do
  self.developer('Postmodern', 'postmodern.mod3@gmail.com')

  self.rspec_options += ['--colour', '--format', 'specdoc']

  self.yard_options += ['--protected']
  self.remote_yard_dir = '/'

  self.extra_deps = [
    ['nokogiri', '>=1.4.0'],
    ['rprogram', '>=0.1.7']
  ]

  self.extra_dev_deps = [
    ['rspec', '>=1.3.0'],
    ['yard', '>=0.5.3']
  ]
end

# vim: syntax=ruby
