class RenameMarkForDeletion < ActiveRecord::Migration
  def change
    rename_column :urls, :mark_for_deletion, :marked_for_deletion
  end
end
