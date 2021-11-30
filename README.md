# ruby-nikto

[![CI](https://github.com/postmodern/ruby-nikto/actions/workflows/ruby.yml/badge.svg)](https://github.com/postmodern/ruby-nikto/actions/workflows/ruby.yml)
[![Gem Version](https://badge.fury.io/rb/ruby-nikto.svg)](https://badge.fury.io/rb/ruby-nikto)

* [Source](https://github.com/sophsec/ruby-nikto)
* [Issues](https://github.com/sophsec/ruby-nikto/issues)

## Description

A Ruby interface to [nikto].

## Features

* Provides a [Ruby interface][Nikto::Command] for running the `nikto` utility.
* Provides a [parser][Nikto::XML] for enumerating Nikto XML scan files.

[Nikto::Command]: https://rubydoc.info/gems/ruby-nikto/Nikto/Command
[Nikto::XML]: https://rubydoc.info/gems/ruby-nikto/Nikto/XML

## Examples

Run Nikto from Ruby:

```ruby
require 'nikto/command'
    
Nikto::Command.run(host: 'example.com', output: 'nikto.xml')
```

Parse Nikto XML scan files:

```ruby
require 'nikto/xml'

Nikto::XML.open('nikto.xml') do |xml|
  xml.each_scan_details do |scan_details|
    puts "#{scan_details.site_name}"

    scan_details.each_item do |item|
      puts "  #{item.uri}"
      puts
      puts "    #{item.description}"
      puts
    end
  end
end
```

## Requirements

* [nikto] >= 2.1.0
* [nokogiri](https://github.com/sparklemotion/nokogiri#readme) ~> 1.0
* [command_mapper](http://github.com/postmodern/command_mapper.rb#readme) ~> 0.1

## Install

```shell
$ gem install ruby-nikto
```

## License

Copyright (c) 2009-2021 Hal Brodigan

See {file:LICENSE.txt} for license information.

[nikto]: https://github.com/sullo/nikto
