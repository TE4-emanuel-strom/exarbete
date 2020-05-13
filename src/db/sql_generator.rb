require_relative 'json_parser'

require 'sqlite3'
require 'json'


def main
    generate_sql "100"
    generate_sql "10k"
    generate_sql "100k"
end


def extract_carts(users)
    carts = users.map { |user| 
        user.delete("cart")
    }
end


def generate_sql(file_name)

    db = SQLite3::Database.new("sql/#{file_name}.db")
    parser = JsonParser.new file_name

    users = parser.users
    carts = extract_carts users
    coffees = parser.coffees


    generate_coffee_table(coffees, db)

    return db

end


def generate_coffee_table(coffees, db)

    create_coffee_table db

    coffees.each { |name, body| 
        origin = body["origin"]
        notes = body["notes"]
        rating = body["rating"]
        code = body["code"]

        query = "
        INSERT INTO coffees
        ( name, origin, notes, rating, code )
        VALUES (?, ?, ?, ?, ?)
        "
        db.execute query, [name, origin, notes, rating, code]
    } 

end


def create_coffee_table(db)

    db.execute "DROP TABLE IF EXISTS coffees"

    query = "CREATE TABLE coffees(
            name varchar(255) NOT NULL UNIQUE,
            origin varchar(255) NOT NULL,
            notes varchar(255) NOT NULL,
            rating int NOT NULL,
            code varchar(255) NOT NULL
    )"
    db.execute query

end

main
