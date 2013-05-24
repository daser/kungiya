class AddFlagToUsers < ActiveRecord::Migration
  def change
    add_column :users, :flag, :boolean, :default=>0
  end
end
