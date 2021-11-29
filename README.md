# ruby-nikto

* [Source](https://github.com/sophsec/ruby-nikto)
* [Issues](https://github.com/sophsec/ruby-nikto/issues)

## Description

A Ruby interface to [nikto].

## Features

* Provides a Ruby interface for running Nikto.
* Provides a Parser for enumerating Nikto XML scan files.

## Examples

Run Nikto from Ruby:

```ruby
require 'nikto/program'
    
Nikto::Program.scan do |nikto|
  # ...
end
```

Parse Nikto XML scan files:

```ruby
require 'nikto/xml'

Nikto::XML.new('scan.xml') do |xml|
  # ...
end
```

## Requirements

* [nikto] >= 2.0.0
* [nokogiri](http://nokogiri.rubyforge.org/) ~> 1.4
* [command_mapper](http://github.com/postmodern/command_mapper.rb#readme) ~> 0.1

## Install

```shell
$ gem install ruby-nikto
```

## License

Copyright (c) 2009-2021 Hal Brodigan

See {file:LICENSE.txt} for license information.

[nikto]: https://github.com/sullo/nikto
