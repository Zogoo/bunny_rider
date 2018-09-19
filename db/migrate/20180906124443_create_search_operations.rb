class CreateSearchOperations < ActiveRecord::Migration[5.2]
  def change
    create_table :search_operations do |t|
      t.string :source_dc
      t.integer :usn
      t.string :status
      t.date :status_update_date
      t.boolean :is_full_sync
      t.string :group_update_type

      t.references :group, foreign_key: { on_delete: :cascade }
      t.references :domain, foreign_key: true

      t.timestamps
    end
  end
end
