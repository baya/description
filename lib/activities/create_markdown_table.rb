class CreateMarkdownTalbe < Dun::Activity
  data_reader :header, :rows

  set :pad_symbol, ' '

  def call
    table_header = []
    table_div    = []
    table_body   = []

    header.each_with_index {|h, index|
      max_length_row = rows.sort_by {|row| row[index].to_s.length }.last
      max_row_length = max_length_row.nil? ? 0 : max_length_row[index].to_s.length
      pad = get_pad(max_row_length - h.length)
      table_header << "#{h}" + pad
    }

    table_header.each {|h| table_div << "-" *  h.length }

    rows.each {|row|
      tr = []
      row.each_with_index {|col, index|
        th = table_header[index]
        pad = get_pad(th.length - col.to_s.length)
        tr << "#{col}" + pad 
      }

      table_body << tr
    }

    table = [table_header, table_div, *table_body]

    table.map {|t| t.join(' | ')}.join("\n")

  end

  private
  
  def get_pad(pad_length)
    pad_length > 0 ? pad_symbol * pad_length : ''
  end
  
end
