class CreateCompanyReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :company_reviews do |t|
      t.references :company, foreign_key: true
      t.references :user, foreign_key: true
      t.text :review
      t.integer :rating

      t.timestamps
    end
  end
end
