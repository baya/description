module Tables

  class Index < Ground::State

    def call
      text = ''
      tables.each {|table|
        text << Description::DescribleTable(table) << "\n\n"
      }

      html markdown(text)
    end

    def tables
      Description::Table_Set
    end
    
  end
  
end
