require "active_record"
require 'yaml'
require 'byebug'

config = YAML.load( File.read('./config/database.yml'))
ActiveRecord::Base.establish_connection(config['development'])

module ActiveRecord
  class Base
    # singleton_class.send(:alias_method, :original_connection, :connection)

    # def self.connection
    #   ActiveRecord::Base.connection_pool.with_connection do |conn|
    #     conn
    #   end
    # end
    def self.close_connect
      self.connection_pool.release_connection
    end
  end
end
