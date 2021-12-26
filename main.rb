require "sqlite3"

db = SQLite3::Database.new('gas_record.sql')

print "command> "
command = gets.chop
if command == "record drive" then
  # 自動車の走行を記録
  print "出発地？>"
  dep = gets.chop
  print "到着地？>"
  dest = gets.chop
  print "走行距離？>"
  dist = gets.chop
  
  db.execute("INSERT INTO drive VALUES(null,?,?,?,?)",Time.now.to_i,dep,dest,dist.to_i)

elsif command == "record gas" then
  # 自動車への給油を記録する
  print "単価？>"
  price = gets.chop
  print "給油量？>"
  amount = gets.chop
  print "金額？>"
  cost = gets.chop

  db.execute("INSERT INTO gas VALUES(null,?,?,?,?)",Time.now.to_i,price.to_i,amount.to_i,cost.to_i)

elsif command == "show drive" then
  # 記録したすべての走行記録を表示
  db.results_as_hash = true
  db.execute('select * from drive') do |row|
    puts "記録日時:" + Time.at(row["date"]).to_s + ",出発地: " + row["dep"].to_s + ",到着地: " + row["dest"].to_s + ",走行距離: " + row["dist"].to_s + "km"
  end

elsif command == "show gas" then
  # 記録したすべての給油を表示
  db.results_as_hash = true
  db.execute('select * from gas') do |row|
    puts "記録日時:" + Time.at(row["date"]).to_s + ",単価: " + row["price"].to_s + "円/L,給油量: " + row["amount"].to_s + "L,合計金額: " + row["cost"].to_s + "円"
  end

end

db.close
