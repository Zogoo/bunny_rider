class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :distinguished_name
      t.string :base
      t.string :object_guid
      t.boolean :account_enabled
      t.boolean :current_member
      t.boolean :sync_required
      t.integer :usn

      t.references :company, foreign_key: { on_delete: :cascade }
      t.references :domain, foreign_key: true
      t.references :group, foreign_key: true
      t.references :search_filter, foreign_key: true
      t.references :search_operation, foreign_key: true

      t.timestamps
    end
  end
end
