require "sqlite3"
require "option_parser"

OptionParser.parse do |parser|
    parser.banner = "Usage: <exec> table-name field1 field2"
    parser.on("-t table_name", "-table=table_name", "specifies table_name") do |table_name|
      tname = table_name
      ready = true
    end 
    parser.on("-f field_name", "-field=field_name", "specifies field_name") { |field_name| dname = field_name }
    parser.on("-i id_field", "-id=id_field", "specifies id_field") { |id_field| pfield = id_field }
    parser.on("-h", "-h=help", "why doesnt this work") { help = true} # TODO -h raises exception...wtf ?
    parser.on("-help", "Show this help message") do 
        puts parser
        exit
    end
    parser.invalid_option do |flag|
    STDERR.puts "ERROR: #{flag} invalid option"
    STDERR.puts parser 
    exit(1)
    end

end

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
        
        rs.each do
            puts "#{rs.read(String)} (#{rs.read(Int32)})"
           
        end
        end
    end
end

if ready == true
  puts "ready to go"
end

#tname, dname, pfield = get_info 
#create_database(tname, dname, pfield)
#populate_database(tname)
