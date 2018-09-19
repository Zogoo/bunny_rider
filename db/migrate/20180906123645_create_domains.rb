class CreateDomains < ActiveRecord::Migration[5.2]
  def change
    create_table :domains do |t|
      t.string :domain
      t.string :protocol
      t.integer :port
      t.string :user_base
      t.string :user_dn
      t.string :user_password

      t.references :company, foreign_key: { on_delete: :cascade }

      t.timestamps
    end

    add_index :domains, :domain, unique: true
  end
end
