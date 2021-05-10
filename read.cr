#
require "./todo"

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

tname = "games"
dname = "name"
pfield = "id"

read_db(tname, dname, pfield)
