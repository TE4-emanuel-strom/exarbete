require 'csv'
require 'sqlite3'

require_relative '../csv/data_parser'


def main(file_name)
    
    db = SQLite3::Database.new "db/sql/#{file_name}.db"
    db.execute "DROP TABLE IF EXISTS single"
    
    data = load(file_name)

    db.execute "CREATE TABLE single (first varchar(15), second varchar(15), third varchar(15))"

    data.each { |table|

        table.each { |row|
            db.execute "INSERT INTO single (first, second, third) 
                        VALUES (?, ?, ?)", row
        }
    }

    sample_thing = data[0][rand(1..100)][1]

    pp sample_thing
    
    pp db.execute "SELECT * FROM single WHERE second = ?", sample_thing

end


main "100_Single"
