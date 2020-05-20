require_relative 'helpers'

require 'leveldb'
require 'sqlite3'
require 'benchmark'
require 'json'

def bm_select_joined_100
    sql_times = []
    nosql_times = []
    db = SQLite3::Database.open "sql/100.db"
    leveldb = LevelDB::DB.new("nosql/100.db")

    pp "100"

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
    
    10000.times do |index|
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
        pp "100: #{index}"
    end
    leveldb.close    
    
    File.open("logs/joined_get_100.txt", "a") { |file| write_to_file(file, sql_times, nosql_times) }
end


def bm_select_joined_10k
    sql_times = []
    nosql_times = []
    db = SQLite3::Database.open "sql/10k.db"
    leveldb = LevelDB::DB.new("nosql/10k.db")

    pp "10k"

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
    
    5000.times do |index|
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
        pp "10k: #{index}"
    end
    leveldb.close    
    
    File.open("logs/joined_get_10k.txt", "a") { |file| write_to_file(file, sql_times, nosql_times) }
end


def bm_select_joined_100k
    sql_times = []
    nosql_times = []
    db = SQLite3::Database.open "sql/100k.db"
    leveldb = LevelDB::DB.new("nosql/100k.db")

    pp "100k"

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
    
    2000.times do |index|
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
        pp "100k: #{index}"
    end
    leveldb.close    
    
    File.open("logs/joined_get_100k.txt", "a") { |file| write_to_file(file, sql_times, nosql_times) }
end
