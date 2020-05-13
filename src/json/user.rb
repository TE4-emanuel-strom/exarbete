require 'faker'
require 'json'

def user(coffees)
    name = Faker::Name.name
    adress = {
            "street" => Faker::Address.street_address,
            "city" => Faker::Address.city,
            "zip" => Faker::Address.zip
    }

    cart = []
    rand(1..10).times {
        cart << coffees.sample
    }

    user = {
        "name" => name,
        "email" => Faker::Internet.email(name: name),
        "adress" => adress,
        "username" => Faker::Internet.username(specifier: name),
        "user_id" => Faker::Number.unique.number(digits: 10),
        "cart" => cart
    }
end
