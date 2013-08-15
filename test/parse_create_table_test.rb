require 'test_helper'

class ParseCreateTableTest < Test::Unit::TestCase

  def test_get_table_name
    migration_dir = File.expand_path File.dirname(__FILE__) + '/migration_examples'
    create_table_code = File.read("#{migration_dir}/create_contests.rb")

    result = Description::ParseCreateTable text: create_table_code

    assert_equal result[:table_name], :contests
      
  end
    
end
