class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :domain_name
      t.string :usn

      t.references :domain, foreign_key: { on_delete: :cascade}

      t.timestamps
    end
  end
end
