def coffee()
    coffee = {
        name: Faker::Coffee.blend_name,
        origin: Faker::Coffee.origin,
        notes: Faker::Coffee.notes,
        rating: rand(1..5),
        code: Faker::Code.unique.isbn
    }
end