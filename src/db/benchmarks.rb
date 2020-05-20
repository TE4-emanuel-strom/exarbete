require_relative 'sql_generator'
require_relative 'nosql_generator'
require_relative 'bm_select_primary'
require_relative 'bm_select_simple'
require_relative 'bm_select_joined'
require_relative 'bm_generate'

def main
    bm_select_joined_all
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

def bm_select_joined_all
    bm_select_joined_100
    bm_select_joined_10k
    bm_select_joined_100k
end

main
