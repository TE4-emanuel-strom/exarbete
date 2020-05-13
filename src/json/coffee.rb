require 'faker'

def stack_shelve()
    Faker::UniqueGenerator.clear
    shelf = []
    
    loop do
        begin
            coffee = {
                "name" => Faker::Coffee.unique.blend_name,
                "origin" => Faker::Coffee.origin,
                "notes" => Faker::Coffee.notes,
                "rating" => rand(1..5),
                "code" => Faker::Code.unique.isbn
            }
            shelf << coffee
            
        rescue
            return shelf
        end

    end

end
