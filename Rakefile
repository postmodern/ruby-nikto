# -*- ruby -*-

require 'rubygems'
require 'hoe'
require './tasks/yard.rb'

Hoe.spec 'ruby-nikto' do
  self.developer('Postmodern', 'postmodern.mod3@gmail.com')

  self.rspec_options += ['--colour', '--format', 'specdoc']

  self.remote_rdoc_dir = '/'
  self.extra_deps = [
    ['nokogiri', '>=1.4.0'],
    ['rprogram', '>=0.1.7']
  ]

  self.extra_dev_deps = [
    ['rspec', '>=1.1.12'],
    ['yard', '>=0.4.0']
  ]

  self.spec_extras = {:has_rdoc => 'yard'}
end

# vim: syntax=ruby
