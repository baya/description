# -*- coding: utf-8 -*-
require 'test_helper'

class ParseRenameColumnTest < Test::Unit::TestCase

  def setup
    migration_dir = File.expand_path File.dirname(__FILE__) + '/migration_examples'
    @code = File.read("#{migration_dir}/add_login_to_users.rb")
  end

  def test
    result = Description::ParseRenameColumn text: @code
    pp result
  end

end
