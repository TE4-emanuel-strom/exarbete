require 'faker'
require 'json'

require_relative 'coffee'

def user()
    name = Faker::Name.name
    adress = {
            "street" => Faker::Address.street_address,
            "city" => Faker::Address.city,
            "zip" => Faker::Address.zip
    }

    cart = []
    rand(1..10).times {
        cart << coffee
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
