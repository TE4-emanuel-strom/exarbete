require_relative 'user'
require_relative 'coffee'

require 'json'

def main
    generate 100
    generate 10000
    generate 100000
end

def generate(num)

    json_name = name(num)
    puts "\nGenerate JSON #{json_name}"

    shelf = stack_shelve
    arr = []

    num.times do |index|
        print "\r#{index + 1} / #{num}" 
         arr << user(shelf) 
    end
    puts "\n"
    json = JSON.generate(arr)

    File.open("#{json_name}.json", 'w') { |file| file.write(json) }
end


def name(num) 
    case num
    when 100
        "100"
    when 10000
        "10k"
    when 100000
        "100k"
    else
        num
    end

end

main
