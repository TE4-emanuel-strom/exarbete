require 'leveldb'
require 'sqlite3'
require 'benchmark'
require_relative 'helpers'


def bm_select_primary_100
    sql_times = []
    nosql_times = []
    db = SQLite3::Database.open "sql/100.db"

    pp "100"

    id = db.execute("SELECT user_id FROM users").flatten.sample
    sql_query ="SELECT * FROM users WHERE user_id = ?"
    
    10000.times do |index|
        sql = Benchmark.realtime do
            db.execute sql_query, id
        end

        leveldb = LevelDB::DB.new("nosql/100.db")

        nosql = Benchmark.realtime do

            leveldb.get(id) 
        end

        leveldb.close

        sql_times << sql
        nosql_times << nosql

        pp "100: #{index}"
    end
    
    File.open("logs/primary_get_100.txt", "a") { |file| write_to_file(file, sql_times, nosql_times) }
end


def bm_select_primary_10k

    sql_times = []
    nosql_times = []
    db = SQLite3::Database.open "sql/10k.db"

    pp "10k"

    id = db.execute("SELECT user_id FROM users").flatten.sample
    sql_query ="SELECT * FROM users WHERE user_id = ?"
    
    10000.times do |index|
        sql = Benchmark.realtime do
            db.execute sql_query, id
        end

        leveldb = LevelDB::DB.new("nosql/10k.db")

        nosql = Benchmark.realtime do

            leveldb.get(id) 
        end

        leveldb.close

        sql_times << sql
        nosql_times << nosql

        pp "10k: #{index}"
    end
    
    File.open("logs/primary_get_10k.txt", "a") { |file| write_to_file(file, sql_times, nosql_times) }
end


def bm_select_primary_100k

    sql_times = []
    nosql_times = []
    db = SQLite3::Database.open "sql/100k.db"

    pp "100k"

    id = db.execute("SELECT user_id FROM users").flatten.sample
    sql_query ="SELECT * FROM users WHERE user_id = ?"
    
    10000.times do |index|
        sql = Benchmark.realtime do
            db.execute sql_query, id
        end

        leveldb = LevelDB::DB.new("nosql/100k.db")

        nosql = Benchmark.realtime do

            leveldb.get(id) 
        end

        leveldb.close

        sql_times << sql
        nosql_times << nosql

        pp "100k: #{index}"
    end
    
    File.open("logs/primary_get_100k.txt", "a") { |file| write_to_file(file, sql_times, nosql_times) }
end
