class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :full_name
      t.string :address
      t.integer :size

      t.timestamps
    end
  end
end
