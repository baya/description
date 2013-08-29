module Description
  class DescribleTable < Dun::Activity
    data_reader :table_name, :columns

    set :header, ['Column', 'Type', 'Modifiers', 'Comment']

    def call
      table = CreateMarkdownTalbe header: header, rows: rows
      "### #{table_name} \n\n" + table
    end

    private

    def rows
      columns.map {|column|
        [column[:column_name], column[:column_type], column[:modifiers], column[:comment]]
      }
    end
    
  end
end
