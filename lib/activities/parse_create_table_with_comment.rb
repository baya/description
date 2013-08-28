# -*- coding: utf-8 -*-
module Description
  # [{method: 'create_table', table_name: 'users', column_name: 'login', column_type: 'string', comment: '登陆名'}]
  class ParseCreateTableWithComment < ParseCreateTable

    attr_reader :code_lines

    set :q_columns, Q?{
      s(:call,
        s(:lvar, atom),
        atom % 'column_type',
        s(atom, atom % 'column_name'),
        ___)
    }

    def initialize(data)
      super
      @code_lines = text.split("\n")
    end

    def call
      (sexp / q_create_table).map {|res|

        (res['columns'] / q_columns).map {|col|
          op = {method: 'create_table'}
          op[:table_name] = res['table_name'].to_s
          op.merge(build_column col)
        }

      }[0]
    end

    private

    def build_column(col)
      column = super
      code_line = code_lines.detect {|line|
        code, _ = line.split("#")
        code and code.include?(col['column_name'].to_s)
      }

      comment = code_line.split("#")[1] if code_line
      column[:comment] = comment if comment
      
      column
    end
    
  end
end
