require_relative("./generator")
require "tty-prompt"

prompt = TTY::Prompt.new
path = prompt.ask("Input generated file destination path:") do |tmp|
    tmp.validate(/\w*[\/]*\w*$/, "Invalid file name!")
end
file_type = prompt.select("What format to generate?", %w(html md))

# test
gen = Generator.new do
    header 'Hello title'
    text 'Some text'
    section 'Section Title', 'Section Text'
    link 'Link text', 'http://url.com'
    image 'alt text',
    'https://raw.githubusercontent.com/adam-p/markdown-here/master/src/common/images/icon48.png'
end
gen.generate(path, file_type)
