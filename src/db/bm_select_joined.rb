require_relative 'helpers'

require 'leveldb'
require 'sqlite3'
require 'benchmark'
require 'json'

def bm_select_joined_100(itterations=103400)
    sql_times = []
    nosql_times = []
    db = SQLite3::Database.open "sql/100.db"
    leveldb = LevelDB::DB.new("nosql/100.db")

    puts "\nSelect Joined 100"

    id = db.execute("SELECT user_id FROM users").flatten.sample
    sql_query = "
    SELECT
     coffees.name AS 'coffee'
    FROM
     users, coffees, carts
    WHERE
     users.user_id = carts.user_id
    AND
     coffees.coffee_id = carts.coffee_id
    AND
     users.user_id = ?
    "
    
    itterations.times do |index|
        print "\r#{index + 1} / #{itterations}"

        sql = Benchmark.realtime do
            db.execute sql_query, id
        end

        nosql = Benchmark.realtime do
            JSON.parse(leveldb.get("user/#{id}"))["cart"]
            .map { |coffee|
                coffee["name"]
            }

        end
        
        sql_times << sql
        nosql_times << nosql
    end

    leveldb.close 
    
    puts "\n"
    
    File.open("logs/joined/100.txt", "a") { |file| write_to_file(file, sql_times, nosql_times) }
end


def bm_select_joined_10k(itterations=10000)
    sql_times = []
    nosql_times = []
    db = SQLite3::Database.open "sql/10k.db"
    leveldb = LevelDB::DB.new("nosql/10k.db")

    puts "\nSelect Joined 10k"

    id = db.execute("SELECT user_id FROM users").flatten.sample
    sql_query = "
    SELECT
     coffees.name AS 'coffee'
    FROM
     users, coffees, carts
    WHERE
     users.user_id = carts.user_id
    AND
     coffees.coffee_id = carts.coffee_id
    AND
     users.user_id = ?
    "
    
    itterations.times do |index|
        print "\r#{index + 1} / #{itterations}"

        sql = Benchmark.realtime do
            db.execute sql_query, id
        end

        nosql = Benchmark.realtime do
            JSON.parse(leveldb.get("user/#{id}"))["cart"]
            .map { |coffee|
                coffee["name"]
            }
        end
        
        sql_times << sql
        nosql_times << nosql
    end

    leveldb.close  
    puts "\n"  
    
    File.open("logs/joined/10k.txt", "a") { |file| write_to_file(file, sql_times, nosql_times) }
end


def bm_select_joined_100k(itterations=200)

    sql_times = []
    nosql_times = []
    db = SQLite3::Database.open "sql/100k.db"
    leveldb = LevelDB::DB.new("nosql/100k.db")

    puts "\nSelect Joined 100k"

    id = db.execute("SELECT user_id FROM users").flatten.sample
    sql_query = "
    SELECT
     coffees.name AS 'coffee'
    FROM
     users, coffees, carts
    WHERE
     users.user_id = carts.user_id
    AND
     coffees.coffee_id = carts.coffee_id
    AND
     users.user_id = ?
    "
    
    itterations.times do |index|
        print "\r#{index + 1} / #{itterations}"

        sql = Benchmark.realtime do
            db.execute sql_query, id
        end

        nosql = Benchmark.realtime do
            JSON.parse(leveldb.get("user/#{id}"))["cart"].map { |coffee|
                coffee["name"]
            }

        end
        
        sql_times << sql
        nosql_times << nosql
    end

    leveldb.close    
    puts "\n"
    
    File.open("logs/joined/100k.txt", "a") { |file| write_to_file(file, sql_times, nosql_times) }
end
