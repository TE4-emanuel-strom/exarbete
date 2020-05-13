require_relative 'json_parser'

require 'leveldb'
require 'json'


def main
    generate_nosql "100"
    generate_nosql "10k"
    generate_nosql "100k"
end


def insert_user(user, db)

    json = JSON.generate user
    name = "user/#{user["name"]}"

    db.put(name, json)
end


def insert_coffee(coffee, db)

    name = coffee.first
    json = JSON.generate({name => coffee[1].merge({"name" => name}) })
    name = "coffee/#{name}"

    db.put(name, json)
end


def generate_nosql(file_name)

    db = LevelDB::DB.new("nosql/#{file_name}.db")
    parser = JsonParser.new file_name

    users = parser.users
    coffees = parser.coffees

    users.each { |user|
        insert_user user, db
    }

    coffees.each { |coffee|
        insert_coffee coffee, db
    }

    return db

end

main

