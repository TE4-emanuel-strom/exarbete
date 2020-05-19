require_relative 'json_parser'

require 'leveldb'
require 'json'
require 'fileutils'


def main
    
end


def insert_user(user, db)

    
    json = JSON.generate user
    id = "user/#{user["user_id"]}"

    db.put(id, json)
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

    db.close

end

main