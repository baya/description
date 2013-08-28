# -*- coding: utf-8 -*-
module Description
  #
  # [{method: 'add_column', table_name: 'users', column_name: 'login', column_type: 'integer', comment: '登陆名'}]
  #
  class ParseAddColumn < Dun::Activity
    
    data_reader :text
    attr_reader :code_lines

    set :q_add_column, Q?{
      s(:call, nil, :add_column,
        s(:lit, atom % 'table_name'),
        s(:lit, atom % 'column_name'),
        s(:lit, atom % 'column_type'),
        ___
        )
    }

    def initialize(data)
      super
      @code_lines = text.split("\n")
    end

    def call
      (sexp / q_add_column).map {|col|

        op = {method: 'add_column', table_name: col['table_name'].to_s}
        op.merge build_column(col)

      }

    end

    private

    def sexp
      @sexp ||= RubyParser.new.parse text
    end

    def build_column(col)
      column = {}
      column[:column_name] = col['column_name'].to_s
      column[:column_type] = col['column_type'].to_s

      code_line = code_lines.detect {|line|
        line.include?('add_column') and line.include?(col['column_name'].to_s)
      }
      comment = code_line.split("#")[1] if code_line
      column[:comment] = comment if comment

      column
    end
    
  end
end
