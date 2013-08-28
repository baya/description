# -*- coding: utf-8 -*-
module Description
  #
  # [{method: 'add_column', table_name: 'users', column_name: 'login', column_type: 'integer', comment: '登陆名'}]
  #
  class ParseAddColumn < ParseColumn

    set :method_name, 'add_column'
    
    set :q_column, Q?{
      s(:call, nil, :add_column,
        s(:lit, atom % 'table_name'),
        s(:lit, atom % 'column_name'),
        s(:lit, atom % 'column_type'),
        ___
        )
    }
    
  end
end
