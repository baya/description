class DescribleTable < Dun::Activity
  data_reader :table_name, :columns

  set :header, ['Column', 'Type', 'Modifiers', 'Comment']

  def call
    table = CreateMarkdownTalbe header: header, rows: rows
    "### #{table_name} \n" + table
  end

  private

  def rows
    columns.map {|column|
      [column[:name], column[:type], column[:modifiers], column[:comment]]
    }
  end
  
end
