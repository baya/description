class CreateMarkdownTalbe < Dun::Activity
  data_reader :header, :rows

  def call
    table_header = []
    table_div    = []
    table_body   = []

    header.each_with_index {|h, index|
      max_length_row = rows.sort_by {|row| row[index].to_s.length }.last
      max_row_length = max_length_row.nil? ? 0 : max_length_row.length
      pad_length = max_row_length - h.length
      if pad_length > 0
        pad = " " * (pad_length - 1)
        th = "#{h}" + pad
      else
        th = "#{h}"
      end
      table_header << th
    }

    table_header.each {|h|
      table_div << "-" * (h.length - 1)
    }

    rows.each {|row|
      table_body << row.map {|col| "#{col}"}
    }

    table = [table_header, table_div, *table_body]

    table.map {|t| t.join(' | ')}.join("\n")

  end
  
end
