class AddUserIdToMessages < ActiveRecord::Migration
  def self.up
    change_table(:messages) do |t|
      t.references :user
    end

  end

  def self.down
    change_table(:messages) do |t|
      t.remove :user
    end
  end
end
