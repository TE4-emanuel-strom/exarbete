def write_to_file(file, sql_times, nosql_times)
    file.write( "#{Time.now}\n" )
    file.write( "SQL Average - #{average(sql_times)}\n" )
    file.write( "NoSQL Average - #{average(nosql_times)}\n" )
    file.write( "Samplesize: #{sql_times.size}\n\n" )
end

def average(arr)
    return arr.sum / arr.size.to_f
end