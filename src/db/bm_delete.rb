require 'leveldb'
require 'sqlite3'
require 'benchmark'
require_relative 'helpers'


def bm_delete_100(itterations=100)

    sql_times = []
    nosql_times = []
    db = SQLite3::Database.open "sql/100.db"
    leveldb = LevelDB::DB.new("nosql/100.db")

    puts "\nDelete 100"

    id = db.execute("SELECT user_id FROM users").flatten.sample
    sql_query ="DELETE FROM users WHERE user_id = ?"

    
    itterations.times do |index|
        print "\r#{index + 1} / #{itterations}"

        sql = Benchmark.realtime do
            db.execute sql_query, id
        end

        nosql = Benchmark.realtime do
            leveldb.delete("user/#{id}") 
        end
            
        
        sql_times << sql
        nosql_times << nosql
    end

    leveldb.close
    puts "\n"

    File.open("logs/delete/100.txt", "a") { |file| write_to_file(file, sql_times, nosql_times) }
end

def bm_delete_10k(itterations=100)

    sql_times = []
    nosql_times = []
    db = SQLite3::Database.open "sql/10k.db"
    leveldb = LevelDB::DB.new("nosql/10k.db")

    puts "\nDelete 10k"

    id = db.execute("SELECT user_id FROM users").flatten.sample
    sql_query ="DELETE FROM users WHERE user_id = ?"

    
    itterations.times do |index|
        print "\r#{index + 1} / #{itterations}"

        sql = Benchmark.realtime do
            db.execute sql_query, id
        end

        nosql = Benchmark.realtime do
            leveldb.delete("user/#{id}") 
        end
            
        
        sql_times << sql
        nosql_times << nosql
    end

    leveldb.close
    puts "\n"

    File.open("logs/delete/10k.txt", "a") { |file| write_to_file(file, sql_times, nosql_times) }
end

def bm_delete_100k(itterations=100)

    sql_times = []
    nosql_times = []
    db = SQLite3::Database.open "sql/100k.db"
    leveldb = LevelDB::DB.new("nosql/100k.db")

    puts "\nDelete 100k"

    id = db.execute("SELECT user_id FROM users").flatten.sample
    sql_query ="DELETE FROM users WHERE user_id = ?"

    
    itterations.times do |index|
        print "\r#{index + 1} / #{itterations}"

        sql = Benchmark.realtime do
            db.execute sql_query, id
        end

        nosql = Benchmark.realtime do
            leveldb.delete("user/#{id}") 
        end
            
        
        sql_times << sql
        nosql_times << nosql
    end

    leveldb.close
    puts "\n"

    File.open("logs/delete/100k.txt", "a") { |file| write_to_file(file, sql_times, nosql_times) }
end
