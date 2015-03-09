require 'sinatra'
require 'pg'
require 'json'

configure do
  enable :sessions
end

DB_NAME = "grocery-list-2"
GROCERIES_TABLE = 'groceries'

def db_connection
  begin
    connection = PG.connect(dbname: DB_NAME)
    yield(connection)
  ensure
    connection.close
  end
end

def get_grocery_list
  db_connection do |conn|
    array = []
    groceries_res = conn.exec("SELECT * FROM #{GROCERIES_TABLE}")
    groceries_res.each do |row|
      array << row
    end
    array
  end
end

get "/groceries.json" do
  content_type :json
  (get_grocery_list).to_json
end


get "/groceries" do
  erb :groceries, locals: { grocery_list: get_grocery_list}
end


get "/" do
  redirect "/groceries"
end


post "/groceries" do 
  new_item = params["grocery_item"]
  groceries = get_grocery_list.map {|item| item["item"] }
  if !groceries.include?(new_item)
    db_connection do |conn|  
      conn.exec_params("INSERT INTO #{GROCERIES_TABLE} (item) VALUES ($1)", [new_item])
    end
  else
    redirect "/groceries"
  end
end

post "/groceries/delete" do
  item_to_delete = params[:delete_grocery_item]
  db_connection do |conn|  
    conn.exec_params("DELETE FROM #{GROCERIES_TABLE} WHERE item = '#{item_to_delete}'")
  end
  redirect "/groceries"
end





