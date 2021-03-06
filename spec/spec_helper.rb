# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
require File.expand_path("../../lib/infoblox", __FILE__)
Bundler.require(:test)
if ENV['INTEGRATION']
  require 'highline/import'
end

module Helper
  def each_version
    ['1.0', '1.2', '1.4', '2.0'].each do |v|
      Infoblox.wapi_version = v
      yield
    end
  ensure
    Infoblox.wapi_version = '2.0'
  end

  def connection
    Infoblox::Connection.new(
      :username => $username,
      :password => $password,
      :host     => $host,
      :ssl_opts => {:verify => false}
      # :logger   => Logger.new(STDOUT)
    )
  end
end

RSpec.configure do |config|
  # config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
  config.include(Helper)
end

if ENV['INTEGRATION']
  $host     = ask("Infoblox host: ")
  $username = ask("Infoblox username: ")
  $password = ask("Infoblox password: ") {|q| q.echo = false }
end
