module Description
  # {
  #   table_name: 'contests',
  #   columns: [
  #              {
  #                column_name:      'id', 
  #                column_type:      'integer', 
  #                modifiers: {}, 
  #                comment:   ''
  #               }, 
  #              ...
  #            ]
  #  }
  class ParseCreateTable < Dun::Activity

    data_reader :text

    set :q_create_table, Q?{
      s(:iter,
        s(:call,
          nil,
          :create_table,
          s(atom, atom % 'table_name'), ___),
        s(:args, atom),
        _ % "columns"
        )
    }
    
    set :q_columns_with_modifiers,  Q?{
      s(:call,
        s(:lvar, atom),
        atom % 'column_type',
        s(atom, atom % 'column_name'),
        _ % 'modifiers')
    }
    
    set :q_modifiers, Q?{
      any(s(atom, atom % 'modifier'),
          s(atom % 'modifier'))
    }
    
    set :q_columns_without_modifiers, Q?{
      s(:call,
        s(:lvar, atom),
        atom % 'column_type',
        s(atom, atom % 'column_name'))
    }
    
    set :q_columns, Q?{
      s(:call,
        s(:lvar, atom),
        atom % 'column_type',
        s(:lit, atom % 'column_name'), ___)
    }

    def call
      tables = (sexp / q_create_table).map {|res|
        table = {}
        table[:table_name] = res['table_name']
        table[:columns] = []
        
        (res['columns'] / q_columns_without_modifiers).each {|col|
          table[:columns] << build_column(col)
        }

        (res['columns'] / q_columns_with_modifiers).each {|col|
          column = build_column col
          modifiers = (col['modifiers'] / q_modifiers).map {|res| res['modifier'] }
          column[:modifiers] = Hash[*modifiers].map {|k, v|
            v = "'#{v}'" if v == ''
            "#{k}:#{v}"
          }.join(', ')

          table[:columns] << column
          
        }
        
        table
      }

      tables

    end

    private

    def sexp
      @sexp ||= RubyParser.new.parse text
    end

    def build_column(col)
      column = {}
      column[:column_name] = col['column_name'].to_s
      column[:column_type] = col['column_type'].to_s
      column
    end

  end
  
end
