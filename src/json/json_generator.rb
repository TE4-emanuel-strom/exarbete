require_relative 'user'
require_relative 'coffee'

require 'json'

def main
    generate 100
    generate 10000
    generate 100000
end

def generate(num)
    shelf = stack_shelve
    arr = []

    num.times { arr << user(shelf) }
    json = JSON.generate(arr)

    File.open("#{name(num)}.json", 'w') { |file| file.write(json) }
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
