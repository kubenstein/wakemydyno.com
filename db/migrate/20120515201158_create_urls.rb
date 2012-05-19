class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :address
      t.boolean :mark_for_deletion
      t.integer :pinged

      t.timestamps
    end
  end
end
