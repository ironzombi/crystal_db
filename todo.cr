require "sqlite3"

def create_database(tname, dname, pfield)
    DB.open "sqlite3://./data.db" do |db|
        db.exec "create table #{tname} (#{dname} text, #{pfield} integer)"
        db.exec "insert into #{tname} values (?, ?)", "John Doe", 30
    
        args = [] of DB::Any
        args << "Sarah"
        args << 33
        db.exec "insert into #{tname} values (?, ?)", args: args
    
        puts "max age:"
        puts db.scalar "select max(#{pfield}) from #{tname}" # => 33
    
        puts "#{tname}:"
        db.query "select #{dname}, #{pfield} from #{tname} order by #{pfield} desc" do |rs|
        puts "#{rs.column_name(0)} (#{rs.column_name(1)})"
        # => name (age)
        rs.each do
            puts "#{rs.read(String)} (#{rs.read(Int32)})"
            # => Sarah (33)
            # => John Doe (30)
        end
        end
    end
end

def read_db(tname, dname, pfield)
    DB.open "sqlite3://./data.db" do |db|
        db.query  "select #{dname}, #{pfield} from #{tname} order by #{pfield} desc" do |rs|
            puts "#{rs.column_name(0)} (#{rs.column_name(1)})"
        # => name (age)
        rs.each do
            puts "#{rs.read(String)} (#{rs.read(Int32)})"
            # => Sarah (33)
            # => John Doe (30)
        end
        end
    end
end

def get_info
    puts "Enter db table"
    table_name = gets
    puts "Enter db description field"
    desc_field = gets
    puts "Enter primary field"
    primary_field = gets
    return table_name, desc_field, primary_field
end

#tname, dname, pfield = get_info 
#create_database(tname, dname, pfield)