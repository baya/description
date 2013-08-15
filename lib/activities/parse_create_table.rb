module Description
  # {
  #   table_name: 'contests',
  #   columns: [
  #              {
  #                name:      'id', 
  #                type:      'integer', 
  #                modifiers: '', 
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
      table_name = (sexp / q_create_table).detect {|res|
        res['table_name']
      }['table_name']

      result[:table_name] = table_name

      result
    end

    private

    def sexp
      @sexp ||= RubyParser.new.parse text
    end

    def q_create_table
      Q?{ s(:call, nil, :create_table, s(:lit, atom % 'table_name')) }
    end
    
  end
end
