require 'json'

class JsonParser

    attr_reader :users, :coffees, :carts


    def initialize(json_file)
        @file_name = "../json/#{json_file}.json"
        @json_raw = get_json
        @users = @json_raw
        @coffees = parse_coffees
        @carts = get_carts
    end


    def get_json
        file = File.open(@file_name)
        json = file.read
        file.close

        return JSON.parse(json)
    end

    def get_carts
        carts = {}
        @users.each { |user| 
            carts[user["user_id"]] = user["cart"]
        }
        carts
    end


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


    def parse_coffees()
        users = @json_raw

        coffees = {}
        users.each { |user|

            user["cart"].each { |item|

                if !coffees.keys.include?(item["name"]) 
                    coffees = coffees.merge coffee_hash(item)
                end
            }
        }

        return coffees
    end

end
