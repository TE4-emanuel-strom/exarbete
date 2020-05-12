def coffee()

    coffee = {
        name: Faker::Coffee.blend_name,
        origin: Faker::Coffee.origin,
        notes: Faker::Coffee.notes
    }

end