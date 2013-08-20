# -*- coding: utf-8 -*-
require 'test_helper'

class CreateAsciiTableTest < Test::Unit::TestCase

  def test_create_ascii_table
    table = CreateAsciiTalbe header: ['Column', 'Type', 'Modifiers', 'Comment'], rows: [['id', 'integer', '', '']]
    puts table
  end

end
