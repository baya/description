# -*- coding: utf-8 -*-
module Description
  #
  # [{method: 'rename_column', table_name: 'users', column_name: 'login', comment: '登陆名'}]
  #
  class ParseRenameColumn < ParseColumn

    set :method_name, 'rename_column'

    set :q_column, Q?{
      s(:call, nil, :rename_column,
        s(:lit, atom % 'table_name'),
        s(:lit, atom),
        s(:lit, atom % 'column_name')
        )
    }

  end
  
end
