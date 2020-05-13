require 'leveldb'
require 'json'


def coffee_hash(item)
    coffee = { 
        item["name"] => {
        "origin" => item["origin"],
        "notes" => item["notes"],
        "rating" => item["rating"],
        "code" => item["code"]
        }
    }
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


def parse_json(file_name)
    db = LevelDB::DB.new "nosql/#{file_name}"

    file = File.open("../json/#{file_name}.json")
    json = file.read
    file.close

    users = JSON.parse(json)

    coffees = {}

    users.each { |user|

        user["cart"].each { |item|

            if !coffees.keys.include?(item["name"]) 
                coffees = coffees.merge coffee_hash(item)
            end
        }

        insert_user user, db
    
    }

    coffees.each { |coffee|
        insert_coffee coffee, db
    }
end

parse_json("10k")