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
    attr_reader :result

    def initialize(data)
      super
      @result = {table_name: '', columns: []}
    end

    def call
      # pp sexp
      table_name = (sexp / q_create_table).detect {|res|
        res['table_name']
      }['table_name']

      result[:table_name] = table_name

      (sexp / q_columns_without_modifiers).each {|res|
        if res['column_name']
          column = {}
          column[:name] = res['column_name']
          column[:type] = res['column_type']
          result[:columns] << column
        end
      }

      (sexp / q_columns_with_modifiers).each {|res|
        if res['column_name']
          column = {}
          column[:name] = res['column_name']
          column[:type] = res['column_type']
          modifiers = (res['modifiers'] / q_modifiers).map {|res|
            res['modifier']
          }

          column[:modifiers] = Hash[*modifiers]
          
          result[:columns] << column
        end
      }

      result
    end

    private

    def sexp
      @sexp ||= RubyParser.new.parse text
    end

    def q_create_table
      Q?{ s(:call, nil, :create_table, s(:lit, atom % 'table_name')) }
    end

    def q_columns_with_modifiers
      Q?{s(:call, s(:lvar, atom), atom % 'column_type', s(:lit, atom % 'column_name'), _ % 'modifiers')}
    end

    def q_modifiers
      Q?{any(s(:lit, atom % 'modifier'), s( atom % 'modifier'))}
    end

    def q_columns_without_modifiers
      Q?{s(:call, s(:lvar, atom), atom % 'column_type', s(:lit, atom % 'column_name'))}
    end

  end
end
