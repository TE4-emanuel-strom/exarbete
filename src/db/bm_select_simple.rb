require 'leveldb'
require 'sqlite3'
require 'benchmark'
require_relative 'helpers'


def bm_select_simple_100

    sql_times = []
    nosql_times = []
    db = SQLite3::Database.open "sql/100.db"
    leveldb = LevelDB::DB.new("nosql/100.db")

    pp "100"

    name = db.execute("SELECT name FROM users").flatten.sample
    sql_query ="SELECT * FROM users WHERE name = ?"
    
    10000.times do |index|
        sql = Benchmark.realtime do
            db.execute sql_query, name
        end


        nosql = Benchmark.realtime do
            key = ""
            leveldb.each do |k, v|

                if v.include? name
                    key = k
                    break
                end

            end

            leveldb.get(key) 
        end
            
        
        sql_times << sql
        nosql_times << nosql
        
        pp "100: #{index}"
    end
    leveldb.close
    
    File.open("logs/simple_get_100.txt", "a") { |file| write_to_file(file, sql_times, nosql_times) }
end

def bm_select_simple_10k

    sql_times = []
    nosql_times = []
    db = SQLite3::Database.open "sql/10k.db"

    pp "10k"

    name = db.execute("SELECT name FROM users").flatten.sample
    sql_query ="SELECT * FROM users WHERE name = ?"
    
    1000.times do |index|
        sql = Benchmark.realtime do
            db.execute sql_query, name
        end

        leveldb = LevelDB::DB.new("nosql/10k.db")

        nosql = Benchmark.realtime do
            key = ""
            leveldb.each do |k, v|

                if v.include? name
                    key = k
                    break
                end

            end

            leveldb.get(key) 
        end          

        leveldb.close

        sql_times << sql
        nosql_times << nosql

        pp "10k: #{index}"
    end
    
    File.open("logs/simple_get_10k.txt", "a") { |file| write_to_file(file, sql_times, nosql_times) }
end

def bm_select_simple_100k

    sql_times = []
    nosql_times = []
    db = SQLite3::Database.open "sql/100k.db"

    pp "100k"

    name = db.execute("SELECT name FROM users").flatten.sample
    sql_query ="SELECT * FROM users WHERE name = ?"
    
    500.times do |index|
        sql = Benchmark.realtime do
            db.execute sql_query, name
        end

        leveldb = LevelDB::DB.new("nosql/100k.db")

        nosql = Benchmark.realtime do
            key = ""
            leveldb.each do |k, v|

                if v.include? name
                    key = k
                    break
                end

            end

            leveldb.get(key) 
        end

        leveldb.close

        sql_times << sql
        nosql_times << nosql

        pp "100k: #{index}"
    end
    
    File.open("logs/simple_get_100k.txt", "a") { |file| write_to_file(file, sql_times, nosql_times) }
end