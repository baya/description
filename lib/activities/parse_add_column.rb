module Description
  #
  # ['add_column', {table_name: 'users', name: 'login', type: 'string'}]
  #
  class ParseAddColumn < Dun::Activity
    
    data_reader :text

    set :q_add_column, Q?{
      s(:call, nil, :add_column,
        s(:lit, atom % 'table_name'),
        s(:lit, atom % 'column_name'),
        s(:lit, atom % 'column_type')
        )
    }


    def call
      (sexp / q_add_column).map {|col|
        ['add_column', {
           table_name: col['table_name'].to_s,
           name: col['column_name'].to_s,
           type: col['column_type'].to_s
         }]
      }
    end

    private

    def sexp
      @sexp ||= RubyParser.new.parse text
    end
    
  end
end
