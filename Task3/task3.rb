class MDHtml
    @result
    def initialize &block
        @result = ""
        instance_eval &block
    end

    def html &block
        @result.concat("<!doctype html>\n\n")
        @result.concat("<html>\n")
        instance_eval &block
        @result.concat("</html>\n")
    end

    def head &block
        @result.concat("<head>\n")
        instance_eval &block
        @result.concat("<head>\n")
    end

    def body &block
        @result.concat("<body>\n")
        instance_eval &block
        @result.concat("</body>\n")
    end

    def div &block
        @result.concat(" <div>")
        @result.concat(block.call(self))
        # puts block.call(self)
        @result.concat("</div>\n")
    end
    
    def meta **array
        if array[:charset]
            @result.concat(" <meta #{array.keys.join}=\"#{array.values.join}\">\n")
        else
            @result.concat(" <meta name=\"#{array.keys.join}\" content=\"#{array.values.join}\">\n")
        end
    end

    def title array
        @result.concat("\n <title>#{array}</title>\n")
    end

    def link **array
        @result.concat("\n <link rel=\"#{array.keys.join}\" href=\"#{array.values.join}\">\n")
    end

    def script **array
        @result.concat( " <script #{array.keys.join}=\"#{array.values.join}\"></script>\n")
    end

    def to_s
        print @result
    end

end


MDHtml.new do
  html do
    head do
      meta charset: "utf-8"
      title "The HTML5 Template"
      meta description: "The HTML5 Template"
      meta author: "MobiDev"
      link stylesheet: "css/styles.css?v=1.0"
    end
    
    body do
      div do
        "Hello World"
      end
      script src:"js/scripts.js"
    end
  end
end.to_s
