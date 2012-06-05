require "simplecov"
require "simplecov-rcov"
require 'webmock/rspec'
require 'vcr'
require 'turn'
#include WebMock::API
require_relative '../lib/multi_shorten'
#WebMock.allow_net_connect!
SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
SimpleCov.start do
  add_filter "vendor"
  add_filter "spec"
end if ENV["COVERAGE"]

Turn.config do |c|
 # :outline  - turn's original case/test outline mode [default]
 c.format  = :outline
 # turn on invoke/execute tracing, enable full backtrace
 c.trace   = true
 # use humanized test names (works only with :outline format)
 c.natural = true
end

#VCR config
VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/multi_shorten_cassettes'
  #c.hook_into :webmock
end