require 'logger'
require 'nested_access/core_ext/hash'
require 'nested_access/core_ext/array'

module NestedAccess

  @logger = Logger.new STDOUT

  def self.log
    @logger
  end
end
