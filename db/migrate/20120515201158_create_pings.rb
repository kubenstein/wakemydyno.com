class CreatePings < ActiveRecord::Migration
  def change
    create_table :pings do |t|
      t.string :url
      t.boolean :mark_for_deletion
      t.integer :counter

      t.timestamps
    end
  end
end
