# -*- coding: utf-8 -*-
require 'test_helper'

class CreateMarkdownTableTest < Test::Unit::TestCase

  def test
    table = CreateMarkdownTalbe header: ['Column', 'Type', 'Modifiers', 'Comment'], rows: [['id', 'integer', '', '']]
    assert_equal table, "Column | Type    | Modifiers | Comment\n------ | ------- | --------- | -------\nid     | integer |           |        "
  end

end
