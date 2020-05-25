require_relative 'sql_generator'
require_relative 'nosql_generator'
require_relative 'bm_select_primary'
require_relative 'bm_select_simple'
require_relative 'bm_select_joined'
require_relative 'bm_generate'
require_relative 'bm_delete'

def main
    start_time = Time.now

    #bm_select_primary_all
    #bm_select_joined_all
    #bm_select_simple_all
    bm_generate_all
    #bm_delete_all

    end_time = Time.now
    elapsed_sec = end_time - start_time
    final_message elapsed_sec
end

def bm_select_primary_all
    bm_select_primary_100(itterations=10000)
    bm_select_primary_10k(itterations=10000)
    bm_select_primary_100k(itterations=10000)
end

def bm_select_joined_all
    bm_select_joined_100(itterations=100000)
    bm_select_joined_10k(itterations=10000)
    bm_select_joined_100k(itterations=5000)
end

def bm_select_simple_all
    bm_select_simple_100(itterations=2500)
    bm_select_simple_10k(itterations=1000)
    bm_select_simple_100k(itterations=500)
end

def bm_generate_all
    bm_generate_100(itterations=500)
    bm_generate_10k(itterations=10)
    bm_generate_100k(itterations=3)
end

def bm_delete_all
    bm_delete_100(itterations=50000)
    bm_delete_10k(itterations=50000)
    bm_delete_100k(itterations=50000)
end

def final_message(time)
    puts "\nAll done!!!"
    puts "It only took #{time}seconds!!!"
    puts "(#{time /60} minuits)"
end

main
