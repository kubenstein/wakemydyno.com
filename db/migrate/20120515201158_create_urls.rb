class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :address
      t.boolean :mark_for_deletion, default: false
      t.integer :pinged, default: 0

      t.timestamps
    end
  end
end
