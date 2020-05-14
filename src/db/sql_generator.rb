require_relative 'json_parser'

require 'sqlite3'
require 'json'


def main
    generate_sql "100"
    generate_sql "10k"
    #generate_sql "100k"
end


def generate_sql(file_name)
    db = SQLite3::Database.new "sql/#{file_name}.db"
    parser = JsonParser.new file_name

    users = parser.users
    carts = parser.carts
    coffees = parser.coffees

    generate_users_table(users, db)
    generate_coffee_table(coffees, db)
    generate_carts_table(carts, db)

    return db
end


def generate_users_table(users, db)
    create_users_table db
    
    users.each { |user| 
    name = user["name"]
    email = user["email"]
    username = user["username"]
    user_id = user["user_id"]
    
    query = "
    INSERT INTO users
    ( name, user_id, email, username )
    VALUES (?, ?, ?, ?)
    "
    pp name
    db.execute query, [name, user_id, email, username]
    } 
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


def generate_carts_table(carts, db)
    create_carts_table db
    
    carts.each { |user_id, coffees| 
    
        coffees.each { |coffee| 
            id_query = "
            SELECT coffee_id FROM COFFEES WHERE name = ?
            "
            coffee_id = db.execute(id_query, coffee["name"]).flatten.first

            insert_query = "
            INSERT INTO carts
            ( user_id, coffee_id )
            VALUES (?, ?)
            "
            pp coffee_id
            db.execute insert_query, [user_id, coffee_id]
        }
    }

end


def create_carts_table(db)
    db.execute "DROP TABLE IF EXISTS carts"
    
    query = "CREATE TABLE carts(
            user_id INTEGER,
            coffee_id INTEGER,

            FOREIGN KEY (user_id) REFERENCES users(user_id)
            FOREIGN KEY (coffee_id) REFERENCES coffees(coffee_id)
    )"
    db.execute query
end


def create_users_table(db)
    db.execute "DROP TABLE IF EXISTS users"
    
    query = "CREATE TABLE users(
        user_id varchar(255) PRIMARY KEY,
        name varchar(255) NOT NULL,
        email varchar(255) NOT NULL,
        username varchar(255) NOT NULL
        )"
        db.execute query
end


def create_adresses_table(db)
    db.execute "DROP TABLE IF EXISTS adresses"
    
    query = "CREATE TABLE adresses(
            adress_id INTEGER PRIMARY KEY AUTOINCREMENT,
            street varchar(255),
            city varchar(255),
            zip varchar(255)
    )"
    db.execute query
end


def create_coffee_table(db)
    db.execute "DROP TABLE IF EXISTS coffees"
    
    query = "CREATE TABLE coffees(
        coffee_id INTEGER PRIMARY KEY AUTOINCREMENT,
        name varchar(255) NOT NULL UNIQUE,
            origin varchar(255) NOT NULL,
            notes varchar(255) NOT NULL,
            rating int NOT NULL,
            code varchar(255) NOT NULL
    )"
    db.execute query
end

main
