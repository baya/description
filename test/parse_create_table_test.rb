# -*- coding: utf-8 -*-
require 'test_helper'

class ParseCreateTableTest < Test::Unit::TestCase

  def setup
    migration_dir = File.expand_path File.dirname(__FILE__) + '/migration_examples'
    @create_table_code = File.read("#{migration_dir}/create_contests.rb")
  end

  def test_get_table_name
    result = Description::ParseCreateTable text: @create_table_code
    assert_equal result[:table_name], :contests
  end

  def test_get_columns
    result = Description::ParseCreateTable text: @create_table_code
    assert_equal result[:columns].size, 17
  end

  def test_get_modifiers
    result = Description::ParseCreateTable text: @create_table_code
    assert_equal result[:columns].last[:modifiers], "default:0"
  end
  
  def test_get_comment
    result = Description::ParseCreateTable text: @create_table_code
    assert_equal result[:columns].last[:comment], '参赛人数'
  end
    
end
