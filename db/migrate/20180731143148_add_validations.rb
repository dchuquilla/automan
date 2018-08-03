class AddValidations < ActiveRecord::Migration[5.2]
  def change
  	add_column :owners, :email, :string, null: false
  	change_column_null :owners, :name, false
  	change_column_null :owners, :last_name, false
  	change_column_null :owners, :cel_phone, true
  	change_column_null :owners, :agreement_terms, false
  	add_index :owners, :email, unique: true
  end
end
