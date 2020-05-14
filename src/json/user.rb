require 'faker'
require 'json'

def user(coffees)
    name = Faker::Name.name

    cart = []
    rand(1..10).times {
        cart << coffees.sample
    }

    user = {
        "name" => name,
        "email" => Faker::Internet.email(name: name),
        "username" => Faker::Internet.username(specifier: name),
        "user_id" => Faker::Number.unique.number(digits: 10),
        "cart" => cart
    }
end
