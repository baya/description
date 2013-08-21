require 'bundler/setup'
Bundler.require(:default)

require 'pp'
require 'activities/parse_create_table'
require 'activities/create_markdown_table'
require 'activities/describle_table'
require 'activities/parse_command_options'
require 'activities/states/tables'
require 'config/routes'


module Description
  App = Ground 'description' do
    use Rack::ShowExceptions
    use Rack::Static, urls: ['/assets']
  end
end

