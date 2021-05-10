require "sqlite3"
require "option_parser"

def create_database(tname, dname, pfield)
    DB.open "sqlite3://./data.db" do |db|
        db.exec "create table #{tname} (#{dname} text, #{pfield} integer)"
    end
end

def populate_database(tname)
    DB.open "sqlite3://./data.db" do |db|
        puts "Game Title ?"
        title = gets
        db.exec "insert into #{tname} values (?, ?)", "#{title}", 80

        args = [] of DB::Any
        args << "MHRise"
        args << 90
        db.exec "insert into #{tname} values (?, ?)", args: args
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

tname, dname, pfield = get_info 
create_database(tname, dname, pfield)
populate_database(tname)
