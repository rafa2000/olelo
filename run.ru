#!/usr/bin/env rackup
require 'wiki'
Wiki::App.set :title, 'Git-Wiki'
Wiki::App.set :repository, File.expand_path(File.join(File.dirname(__FILE__), 'git', 'repository'))
Wiki::App.set :workspace, File.expand_path(File.join(File.dirname(__FILE__), 'git' , 'workspace'))
logger = Logger.new(STDOUT)
logger.level = Logger::INFO
Wiki::App.set :logger, logger
run Wiki::App

