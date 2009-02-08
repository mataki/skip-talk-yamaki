class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :ident_url
      t.string :name
      t.string :display_name

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
