# -*- coding: utf-8 -*-
require 'test_helper'

class CreateMarkdownTableTest < Test::Unit::TestCase

  def test_create_markdown_table_header
    table = CreateMarkdownTalbe header: ['Column', 'Type', 'Modifiers', 'Comment'], rows: []
    # pp table
    assert_equal table, <<-EOF.strip
      Column | Type | Modifiers | Comment
    EOF
  end

  def test_create_markdown_table_header
    table = CreateMarkdownTalbe header: ['Column', 'Type', 'Modifiers', 'Comment'], rows: [['id', 'integer', '', '']]
    pp table
    assert_equal table, <<-EOF.strip
      Column | Type    | Modifiers | Comment
      ------ | ------- | --------- | -------
      id     | integer |           |
    EOF
  end

end
