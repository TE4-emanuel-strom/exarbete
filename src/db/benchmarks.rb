require_relative 'sql_generator'
require_relative 'nosql_generator'
require 'benchmark'


def main
    bm_select_primary_all
end


def bm_generate_all
    bm_generate_100
    bm_generate_10k
    bm_generate_100k
end

def bm_select_simple_all
    bm_select_simple_100
    bm_select_simple_10k
    bm_select_simple_100k
end

def bm_select_primary_all
    bm_select_primary_100
    bm_select_primary_10k
    bm_select_primary_100k
end


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
    
    File.open("logs/primary_get_100", "a") { |file| write_to_file(file, sql_times, nosql_times) }
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
    
    File.open("logs/primary_get_10k", "a") { |file| write_to_file(file, sql_times, nosql_times) }
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
    
    File.open("logs/primary_get_100k", "a") { |file| write_to_file(file, sql_times, nosql_times) }
end

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
    
    File.open("logs/simple_get_100", "a") { |file| write_to_file(file, sql_times, nosql_times) }
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
    
    File.open("logs/simple_get_10k", "a") { |file| write_to_file(file, sql_times, nosql_times) }
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
    
    File.open("logs/simple_get_100k", "a") { |file| write_to_file(file, sql_times, nosql_times) }
end


def bm_generate_100
    sql_times = []
    nosql_times = []

    i = 1
    pp "100"
    
    100.times {

        nosql = Benchmark.realtime {
            generate_nosql "100"
        }

        sql = Benchmark.realtime {
            generate_sql "100"
        }
        
        nosql_times << nosql
        sql_times << sql
        pp i
        i += 1
    }

    avg_sql = average(sql_times)
    avg_nosql = average(nosql_times)

    File.open("logs/generate100", "a") { |file| write_to_file(file, sql_times, nosql_times) }
end


def bm_generate_10k
    sql_times = []
    nosql_times = []

    i = 1
    pp "10k"
    
    10.times {

        nosql = Benchmark.realtime {
            generate_nosql "10k"
        }

        sql = Benchmark.realtime {
            generate_sql "10k"
        }
        
        nosql_times << nosql
        sql_times << sql
        pp i
        i += 1
    }

    avg_sql = average(sql_times)
    avg_nosql = average(nosql_times)

    File.open("logs/generate10k", "a") { |file| write_to_file(file, sql_times, nosql_times) }
end


def bm_generate_100k
    sql_times = []
    nosql_times = []

    i = 1
    pp "100k"
    
    5.times {

        nosql = Benchmark.realtime {
            generate_nosql "100k"
        }

        sql = Benchmark.realtime {
            generate_sql "100k"
        }
        
        nosql_times << nosql
        sql_times << sql
        pp i
        i += 1
    }

    avg_sql = average(sql_times)
    avg_nosql = average(nosql_times)

    File.open("logs/generate100k", "a") { |file| write_to_file(file, sql_times, nosql_times) }
end


def write_to_file(file, sql_times, nosql_times)
    file.write( "#{Time.now}\n" )
    file.write( "SQL Average - #{average(sql_times)}\n" )
    file.write( "NoSQL Average - #{average(nosql_times)}\n" )
    file.write( "Samplesize: #{sql_times.size}\n\n" )
end


def average(arr)
    return arr.sum / arr.size.to_f
end

main
