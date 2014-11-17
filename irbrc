require 'pp'
require 'rubygems'
require 'irb/completion'

def sql_logging
  ActiveRecord::Base.connection.instance_variable_set :@logger, Logger.new(STDOUT)
end  
