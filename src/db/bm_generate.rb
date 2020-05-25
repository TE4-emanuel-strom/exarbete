require 'leveldb'
require 'sqlite3'
require 'benchmark'
require_relative 'helpers'


def bm_generate_100(itterations=10)
    sql_times = []
    nosql_times = []

    i = 1
    puts "\nGenerate 100"
    
    itterations.times do |index| 

        print "\r#{index + 1} / #{itterations}"

        nosql = Benchmark.realtime {
            generate_nosql "100"
        }

        sql = Benchmark.realtime {
            generate_sql "100"
        }
        
        nosql_times << nosql
        sql_times << sql
    end

    puts "\n"

    File.open("logs/generate/100.txt", "a") { |file| write_to_file(file, sql_times, nosql_times) }
end


def bm_generate_10k(itterations=3)
    sql_times = []
    nosql_times = []

    puts "\nGenerate 10k"
    
    itterations.times do |index|
        print "\r#{index + 1} / #{itterations}"

        nosql = Benchmark.realtime {
            generate_nosql "10k"
        }

        sql = Benchmark.realtime {
            generate_sql "10k"
        }
        
        nosql_times << nosql
        sql_times << sql
    end

    puts "\n"

    File.open("logs/generate/10k.txt", "a") { |file| write_to_file(file, sql_times, nosql_times) }
end


def bm_generate_100k(itterations=1)
    sql_times = []
    nosql_times = []

    puts "\nGenerate 100k"
    itterations = 5
    
    itterations.times do |index|
        print "\r#{index + 1} / #{itterations}"

        nosql = Benchmark.realtime {
            generate_nosql "100k"
        }

        sql = Benchmark.realtime {
            generate_sql "100k"
        }
        
        nosql_times << nosql
        sql_times << sql
    end

    puts "\n"

    File.open("logs/generate/100k.txt", "a") { |file| write_to_file(file, sql_times, nosql_times) }
end