class CreateAsciiTalbe < Dun::Activity
  data_reader :header, :rows

  def call
    Terminal::Table.new(headings: header) do |t|
      rows.each_with_index do |row, index|
        t.add_row row
        t.add_separator if index < rows.size - 1
      end
    end
  end
  
end
