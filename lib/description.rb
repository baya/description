# ground_dir = '/Users/jiangguimin/Projects/ground/lib'
# ground_dir = '/Users/jim/Projects/ground/lib'
# $LOAD_PATH.unshift ground_dir unless $LOAD_PATH.include?(ground_dir)

require 'bundler'
Bundler.require(:default)
require 'pp'
require 'optparse'
require 'logger'

require 'activities/parse_create_table'
require 'activities/parse_create_table_with_comment'
require 'activities/parse_column'
require 'activities/parse_add_column'
require 'activities/parse_rename_column'
require 'activities/create_markdown_table'
require 'activities/describle_table'
require 'activities/parse_command_options'
require 'activities/states/tables'
require 'activities/states/index'
require 'config/routes'
require 'config/sets'
require 'config/helpers'

module Description
  Table_Set = []
  App = Ground 'description' do
    use Rack::ShowExceptions
    use Rack::Static, urls: ['/js', '/css', '/lib', '/partials'], :root => "lib/app"
    use Ground::UrlSuffix
  end
end

