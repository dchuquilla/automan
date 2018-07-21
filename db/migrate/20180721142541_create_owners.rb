class CreateOwners < ActiveRecord::Migration[5.2]
  def change
    create_table :owners do |t|
      t.string :name
      t.string :last_name
      t.string :cel_phone
      t.boolean :agreement_terms

      t.timestamps
    end
  end
end
