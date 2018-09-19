class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.integer :sync_time

      t.timestamps
    end

    add_index :companies, :name, unique: true
  end
end
