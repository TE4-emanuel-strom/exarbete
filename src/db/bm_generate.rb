require 'leveldb'
require 'sqlite3'
require 'benchmark'
require_relative 'helpers'


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

    File.open("logs/generate100.txt", "a") { |file| write_to_file(file, sql_times, nosql_times) }
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

    File.open("logs/generate10k.txt", "a") { |file| write_to_file(file, sql_times, nosql_times) }
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

    File.open("logs/generate100k.txt", "a") { |file| write_to_file(file, sql_times, nosql_times) }
end