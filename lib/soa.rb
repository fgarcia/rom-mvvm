require 'bundler'
Bundler.require

$LOAD_PATH << __dir__

require 'soa/models'
require 'soa/rom_adapters'
require 'soa/rom_mappers'
require 'soa/services'

def demo
  customer = Customer.new(name:'John')

  # from Customer to CustomerAPI ???
end

demo
