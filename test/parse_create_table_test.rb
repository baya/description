# -*- coding: utf-8 -*-
require 'test_helper'

class ParseCreateTableTest < Test::Unit::TestCase

  def setup
    migration_dir = File.expand_path File.dirname(__FILE__) + '/migration_examples'
    @schema_code = File.read("#{migration_dir}/schema.rb")
  end

  def test
    result = Description::ParseCreateTable text: @schema_code
    pp result
  end
 
end
