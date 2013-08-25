module Tables

  State = Ground::State

  class Index < State

    def call
      if request_accept?(:json)
        json tables.to_json
      else  
        text = ''
        tables.each {|table|
          text << Description::DescribleTable(table) << "\n\n"
        }
        html markdown(text)
      end
    end

    def tables
      Description::Table_Set
    end
    
  end

  class Show < State

    def call
      @table = find_table_by_name(params[:name])
      if @table.nil?
        return non_found("The table #{params[:name]} not found")
      end
      if request_accept?(:json)
        json @table.to_json
      else
        text @table.inspect
      end
    end

    private
    
    def find_table_by_name(name)
      Description::Table_Set.detect {|table| table[:table_name].to_s == name}
    end
    
  end

end
