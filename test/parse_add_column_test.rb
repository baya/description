# -*- coding: utf-8 -*-
require 'test_helper'

class ParseAddColumnTest < Test::Unit::TestCase

  def setup
    migration_dir = File.expand_path File.dirname(__FILE__) + '/migration_examples'
    @add_column_code = File.read("#{migration_dir}/add_login_to_users.rb")
  end

  def test
    result = Description::ParseAddColumn text: @add_column_code
    pp result
  end

end
