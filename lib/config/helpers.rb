Ground do

  help Ground::State do

    def markdown text
      Kramdown::Document.new(text).to_html
    end
    
  end
  
end
