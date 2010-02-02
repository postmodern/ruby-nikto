# ruby-nikto

* http://github.com/sophsec/ruby-nikto
* http://github.com/sophsec/ruby-nikto/issues
* Postmodern (postmodern.mod3 at gmail.com)

## DESCRIPTION:

A Ruby interface to Nikto.

## FEATURES:

* Provides a Ruby interface for running Nikto.
* Provides a Parser for enumerating Nikto XML scan files.

## EXAMPLES:

Run Nikto from Ruby:

    require 'nikto/program'
    
    Nikto::Program.scan do |nikto|
    end

Parse Nikto XML scan files:

    require 'nikto/xml'

    Nikto::XML.new('scan.xml') do |xml|
    end

## REQUIREMENTS:

* [nikto](http://cirt.net/nikto2) >= 2.0.0
* [nokogiri](http://nokogiri.rubyforge.org/) >= 1.4.0
* [rprogram](http://rprogram.rubyforge.org/) >= 0.1.7

## INSTALL:

    $ sudo gem install ruby-nikto

## LICENSE:

The MIT License

Copyright (c) 2009 Hal Brodigan

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
