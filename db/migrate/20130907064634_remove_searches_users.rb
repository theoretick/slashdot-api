class RemoveSearchesUsers < ActiveRecord::Migration
  def change
    drop_table :searches_users
  end
end
