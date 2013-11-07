require 'bundler/setup'
require 'celluloid'

BASEPATH = File.expand_path('../../', __FILE__)
$:.unshift "#{BASEPATH}/lib"

Celluloid.logger = Logger.new("#{BASEPATH}/log/celluloid.log")
