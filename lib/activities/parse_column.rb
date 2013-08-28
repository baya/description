# -*- coding: utf-8 -*-
module Description
  #
  # [{method: 'add_column', table_name: 'users', column_name: 'login', column_type: 'integer', comment: '登陆名'}]
  #
  class ParseColumn < Dun::Activity
    
    data_reader :text
    attr_reader :code_lines

    def initialize(data)
      super
      @code_lines = text.split("\n")
    end

    def call
      (sexp / q_column).map {|col|

        op = {method: method_name, table_name: col['table_name'].to_s}
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
      column[:column_type] = col['column_type'].to_s if col['column_type']

      code_line = code_lines.detect {|line|
        code, comment = line.split("#")
        code.include?(method_name) and code.include?(col['column_name'].to_s)
      }
      comment = code_line.split("#")[1] if code_line
      column[:comment] = comment if comment

      column
    end
    
  end
end
