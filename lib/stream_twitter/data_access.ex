defmodule StreamTwitter.DataAccess do

  @opts [:bag, :protected, :named_table]
  @table "tweets"

  def init(db_name, opts \\ @opts)
  def init(db_name, opts), do: :ets.new(db_name, opts)

  def create(db_name, table_name \\ @table, text)
  def create(db_name, table_name, data), do: :ets.insert(db_name, {table_name, data})

  def retrieve(db_name, table_name \\ @table)
  def retrieve(db_name, table_name), do: :ets.lookup(db_name, table_name)

end
