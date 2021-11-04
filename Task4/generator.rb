class Generator
    attr_accessor :result

    def initialize &block
        @result = []
        instance_eval &block
    end

    def header title
        @result << Hash["header" => title]
    end

    def text text
        @result << Hash["text" => text]
    end

    def section sect_title, sect_text
        @result << Hash["section" => [sect_title, sect_text]]
    end

    def link link_text, link_url
        @result << Hash["link" => [link_text, link_url]]
    end

    def image img_text, img_url
        @result << Hash["image" => [img_text, img_url]]
    end

    def generate path, file_type
        unless path
            puts "No path specified"
            puts "Creating by default"
            unless File.directory?("./build")
                Dir.mkdir("./build")
            end
            path = "./build/README"
        else
            splitted_path = path.split('/')
            splitted_path.pop
            splitted_path = splitted_path.join('/').to_s
            unless File.directory?(File.expand_path(splitted_path))
                puts "Path doesn't existt"
                puts "Creating by default"
                unless File.directory?("./build")
                    Dir.mkdir("./build")
                end
                path = "./build/README"
            end
        end
        path = File.expand_path(path)

        tmp = ""
        if file_type == "md"
            @result.each do |n|
                case n.keys.first
                when "header"
                    tmp << "# #{n.values[0]}\n"
                when "text"
                    tmp << "#{n.values[0]}\n"
                when "section"
                    tmp << "# #{n.values[0][0]}\n"
                    tmp << "#{n.values[0][1]}\n"
                when "link"
                    tmp << "[#{n.values[0][0]}] (#{n.values[0][1]})\n"
                when "image"
                    tmp << "! [#{n.values[0][0]} (#{n.values[0][1]})\n"
                end
            end
        elsif file_type == "html"
            @result.each do |n|
                case n.keys.first
                when "header"
                    tmp << "<h1>#{n.values[0]}</h1>\n"
                when "text"
                    tmp << "<p>#{n.values[0]}</p>\n"
                when "section"
                    tmp << "<h1>#{n.values[0][0]}</h1>\n"
                    tmp << "<p>#{n.values[0][1]}</p>\n"
                when "link"
                    tmp << "<a href=\"#{n.values[0][1]}\">#{n.values[0][0]}</a>\n"
                when "image"
                    tmp << "<img scr=\"#{n.values[0][1]}\" alt=\"#{n.values[0][0]}\">\n"
                end
            end
        else
            puts "Wrong file type!"
            return
        end
        file = File.new("#{path}.#{file_type}", "w")
        file << tmp
        file.close
    end
end
