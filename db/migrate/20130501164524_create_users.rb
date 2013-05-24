class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :company
      t.text :description

      t.timestamps
    end
  end
  def self.down
      drop_table :users
  end
end
