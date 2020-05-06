require 'faker'
require 'byebug'
require 'csv'


def generate(quantity, complexity)

    if validQuantity quantity

        case complexity
        when "single"
            single quantity
        when "double"
            double quantity
        when "triple"
            triple quantity
        else
            unvalid complexity
        end
    else
        puts "Error: Unvalid quantity #{quantity}. Please enter an Integer quantity 100, 10000 or 1000000"
    end

end


def single(quantity)

    names = {100 => "100", 10000 => "10k", 1000000 => "1M"}

    fileName = "#{names[quantity]}_Single"

    writeCsvFile quantity, fileName, 1

    puts "Sucsessfully generated file #{fileName}.csv"
end



def double(quantity)
    
    names = {100 => "100", 10000 => "10k", 1000000 => "1M"}

    fileName = "#{names[quantity]}_Double"

    writeCsvFile quantity, fileName, 2

    puts "Sucsessfully generated file #{fileName}.csv"
end

def triple(quantity)
    
    names = {100 => "100", 10000 => "10k", 1000000 => "1M"}

    fileName = "#{names[quantity]}_Triple"

    writeCsvFile quantity, fileName, 3

    puts "Sucsessfully generated file #{fileName}.csv"

end


def writeCsvFile(quantity, fileName, tables)

    
    CSV.open("../csv/#{fileName}.csv", "w") do |csv|
        tables.times {
            quantity.times {
                row = []
                
                3.times {
                    row << Faker::Alphanumeric.alpha(number: rand(5..10))
                }
                csv << row
            }
            csv << []
        }
        end

end


def unvalid(complexity)
    puts("Error: unvalid complexity '#{complexity}'. Please enter a string complexity single, double or triple")
end

def validQuantity(quantity)
    return [100, 10000, 1000000].include?(quantity)
end

generate 100, "single"
generate 100, "double"
generate 100, "triple"

generate 10000, "single"
generate 10000, "double"
generate 10000, "triple"

generate 1000000, "single"
generate 1000000, "double"
generate 1000000, "triple"