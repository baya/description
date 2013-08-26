module Description
  # {
  #   table_name: 'contests',
  #   columns: [
  #              {
  #                name:      'id', 
  #                type:      'integer', 
  #                modifiers: {}, 
  #                comment:   ''
  #               }, 
  #              ...
  #            ]
  #  }
  class ParseCreateTable < Dun::Activity

    data_reader :text
    attr_reader :code_lines

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

    def initialize(data)
      super
      @code_lines = text.split("\n")
    end

    def call
      # pp sexp
      # pp sexp / q_create_table
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
      column[:name] = col['column_name']
      column[:type] = col['column_type']
      line = code_lines.detect {|line| line.include? column[:name].to_s }
      comment = line.split("#")[1]
      column[:comment] = comment.lstrip if comment
      
      column
    end

  end
  
end
