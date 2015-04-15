# Deir

Deis Controller API bindings in Ruby.

## Install

```bash
$ gem build deir.gemspec
$ gem install deir-0.0.1.pre.gem
```

## Usage

```
$ irb
irb(main):001:0> require 'deis'
=> true
irb(main):002:0> Deis::Client
=> Deis::Client
irb(main):003:0> Deis::Client.new('http://local3.deisapp.com', 'my-secret-auth-token')
irb(main):005:0> client.apps_list
```
