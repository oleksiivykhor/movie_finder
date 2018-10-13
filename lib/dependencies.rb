require 'capybara'
require 'capybara/dsl'
require 'rspec'
require 'byebug'
require 'erb'
require 'logger'

ENV['HOME'] = File.expand_path('../../', __FILE__)
$LOAD_PATH << ENV['HOME']

require 'lib/exceptions'
require 'lib/movie_finder_logger'
require 'lib/helpers'
require 'lib/finders/base_finder'
require 'lib/converters/base_converter'
require 'lib/generators/base_generator'
