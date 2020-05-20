require 'leveldb'
require 'sqlite3'
require 'benchmark'
require_relative 'helpers'


def bm_select_primary_100(itterations=1000)
    sql_times = []
    nosql_times = []
    db = SQLite3::Database.open "sql/100.db"

    puts "\nSelect Primary 100"

    id = db.execute("SELECT user_id FROM users").flatten.sample
    sql_query ="SELECT * FROM users WHERE user_id = ?"

    itterations.times do |index|
        print "\r#{index + 1} / #{itterations}"

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
    end

    puts "\n"
    
    File.open("logs/primary/100.txt", "a") { |file| write_to_file(file, sql_times, nosql_times) }
end


def bm_select_primary_10k(itterations=1000)

    sql_times = []
    nosql_times = []
    db = SQLite3::Database.open "sql/10k.db"

    puts "\nSelect Primary 10k"

    id = db.execute("SELECT user_id FROM users").flatten.sample
    sql_query ="SELECT * FROM users WHERE user_id = ?"

    itterations.times do |index|
        print "\r#{index + 1} / #{itterations}"

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
    end

    puts "\n"
    File.open("logs/primary/10k.txt", "a") { |file| write_to_file(file, sql_times, nosql_times) }
end


def bm_select_primary_100k(itterations=100)

    sql_times = []
    nosql_times = []
    db = SQLite3::Database.open "sql/100k.db"

    puts "\nSelect Primary 100k"

    id = db.execute("SELECT user_id FROM users").flatten.sample
    sql_query ="SELECT * FROM users WHERE user_id = ?"

    itterations.times do |index|
        print "\r#{index + 1} / #{itterations}"

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
    end

    puts "\n"
    
    File.open("logs/primary/100k.txt", "a") { |file| write_to_file(file, sql_times, nosql_times) }
end
