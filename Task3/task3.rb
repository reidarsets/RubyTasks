class MDHtml
    attr_accessor :result
    
    def initialize &block
        self.result = ""
        instance_eval &block
    end

    def html &block
        self.result.concat("<!doctype html>\n\n")
        self.result.concat("<html>\n")
        instance_eval &block
        self.result.concat("</html>\n")
    end

    def head &block
        self.result.concat("<head>\n")
        instance_eval &block
        self.result.concat("<head>\n")
    end

    def body &block
        self.result.concat("<body>\n")
        instance_eval &block
        self.result.concat("</body>\n")
    end

    def div &block
        self.result.concat(" <div>")
        self.result.concat(block.call(self))
        # puts block.call(self)
        self.result.concat("</div>\n")
    end
    
    def meta **params
        if params[:charset]
            self.result.concat(" <meta #{params.first.first}=\"#{params.values[0]}\">\n")
        else
            self.result.concat(" <meta name=\"#{params.first.first}\" content=\"#{params.values[0]}\">\n")
        end
    end

    def title params
        self.result.concat("\n <title>#{params}</title>\n")
    end

    def link **params
        self.result.concat("\n <link rel=\"#{params.first.first}\" href=\"#{params.values[0]}\">\n")
    end

    def script **params
        self.result.concat( " <script #{params.first.first}=\"#{params.values[0]}\"></script>\n")
    end

    def to_s
        print self.result
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
