class CreateSearchFilters < ActiveRecord::Migration[5.2]
  def change
    create_table :search_filters do |t|
      t.string :label
      t.string :group
      t.boolean :user_domain_users_group
      t.boolean :is_match
      t.boolean :is_sync_required

      t.references :group, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
