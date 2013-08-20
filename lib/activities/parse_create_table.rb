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
    attr_reader :code_lines

    set :q_create_table, Q?{ s(:call, nil, :create_table, s(:lit, atom % 'table_name')) }
    set :q_columns_with_modifiers,
    Q?{s(:call, s(:lvar, atom), atom % 'column_type', s(:lit, atom % 'column_name'), _ % 'modifiers')}
    set :q_modifiers, Q?{any(s(:lit, atom % 'modifier'), s(atom % 'modifier'))}
    set :q_columns_without_modifiers, Q?{s(:call, s(:lvar, atom), atom % 'column_type', s(:lit, atom % 'column_name'))}
    set :q_columns, Q?{s(:call, s(:lvar, atom), atom % 'column_type', s(:lit, atom % 'column_name'), ___)}

    def initialize(data)
      super
      @result = {table_name: '', columns: []}
      @code_lines = text.split("\n")
    end

    def call
      table_name = (sexp / q_create_table).detect {|res|
        res['table_name']
      }['table_name']
      result[:table_name] = table_name

      (sexp / q_columns_without_modifiers).each {|res|
        if res['column_name']
          result[:columns] << build_column(res)
        end
      }

      (sexp / q_columns_with_modifiers).each {|res|
        if res['column_name']
          column = build_column res
          modifiers = (res['modifiers'] / q_modifiers).map {|res| res['modifier'] }
          column[:modifiers] = Hash[*modifiers].map {|k, v| "#{k}:#{v}"}.join(', ')
          result[:columns] << column
        end
      }

      result
    end

    private

    def sexp
      @sexp ||= RubyParser.new.parse text
    end

    def build_column(res)
      column = {}
      column[:name] = res['column_name']
      column[:type] = res['column_type']
      line = code_lines.detect {|line| line.include? column[:name].to_s }
      comment = line.split("#")[1]
      column[:comment] = comment.lstrip if comment
      
      column
    end

  end
  
end
