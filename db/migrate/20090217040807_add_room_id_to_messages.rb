class AddRoomIdToMessages < ActiveRecord::Migration
  def self.up
    change_table :messages do |t|
      t.references :room
    end
  end

  def self.down
    change_table :messages do |t|
      t.remove :room
    end
  end
end
