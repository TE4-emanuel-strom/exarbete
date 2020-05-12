require_relative 'user'
require 'json'

def generate(num)

    arr = []

    num.times { arr << user }
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
