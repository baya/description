# -*- coding: utf-8 -*-
require 'test_helper'

class ParseCreateTableWithCommentTest < Test::Unit::TestCase

  def setup
    migration_dir = File.expand_path File.dirname(__FILE__) + '/migration_examples'
    @code = File.read("#{migration_dir}/create_contests.rb")
  end

  def test
    result = Description::ParseCreateTableWithComment text: @code
    pp result
  end
 
end
