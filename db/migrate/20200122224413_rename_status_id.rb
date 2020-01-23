class RenameStatusId < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :status_id, :done
    change_column :tasks, :done, 'boolean USING CAST(done AS boolean)'
  end
end
