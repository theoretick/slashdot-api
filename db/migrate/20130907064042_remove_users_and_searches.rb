class RemoveUsersAndSearches < ActiveRecord::Migration
  def change
    drop_table :users
    drop_table :searches
  end
end
