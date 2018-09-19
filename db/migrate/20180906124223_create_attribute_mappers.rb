class CreateAttributeMappers < ActiveRecord::Migration[5.2]
  def change
    create_table :attribute_mappers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email_address
      t.string :department
      t.string :phone_number
      t.string :postal_code
      t.string :perfecture
      t.string :ward
      t.string :address

      t.references :company, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
