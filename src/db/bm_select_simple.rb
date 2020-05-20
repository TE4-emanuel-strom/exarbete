require 'leveldb'
require 'sqlite3'
require 'benchmark'
require_relative 'helpers'


def bm_select_simple_100(itterations=1000)

    sql_times = []
    nosql_times = []
    db = SQLite3::Database.open "sql/100.db"
    leveldb = LevelDB::DB.new("nosql/100.db")

    puts "\nSelect Simple 100"

    name = db.execute("SELECT name FROM users").flatten.sample
    sql_query ="SELECT * FROM users WHERE name = ?"
    
    itterations.times do |index|
        print "\r#{index + 1} / #{itterations}"

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
    end

    leveldb.close
    puts "\n"
    
    File.open("logs/simple/100.txt", "a") { |file| write_to_file(file, sql_times, nosql_times) }
end

def bm_select_simple_10k(itterations=1000)

    sql_times = []
    nosql_times = []
    db = SQLite3::Database.open "sql/10k.db"

    puts "\nSelect Simple 10k"

    name = db.execute("SELECT name FROM users").flatten.sample
    sql_query ="SELECT * FROM users WHERE name = ?"
    
    itterations.times do |index|
        print "\r#{index + 1} / #{itterations}"

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
    end
    
    puts "\n"
    File.open("logs/simple/10k.txt", "a") { |file| write_to_file(file, sql_times, nosql_times) }
end

def bm_select_simple_100k(itterations=100)

    sql_times = []
    nosql_times = []
    db = SQLite3::Database.open "sql/100k.db"

    puts "\nSelect Simple 100k"

    name = db.execute("SELECT name FROM users").flatten.sample
    sql_query ="SELECT * FROM users WHERE name = ?"
    
    itterations.times do |index|
        print "\r#{index + 1} / #{itterations}"

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
    end
    
    puts "\n"
    File.open("logs/simple/100k.txt", "a") { |file| write_to_file(file, sql_times, nosql_times) }
end