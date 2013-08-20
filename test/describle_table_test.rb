require 'test_helper'

class DescribleTableTest < Test::Unit::TestCase

  def setup
    migration_dir = File.expand_path File.dirname(__FILE__) + '/migration_examples'
    @create_table_code = File.read("#{migration_dir}/create_contests.rb")
  end

  def test_describle_table
    result = Description::ParseCreateTable text: @create_table_code
    table = DescribleTable result
    puts table
  end
  
end
