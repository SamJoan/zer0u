class CreateDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :documents do |t|
      t.text :from
      t.date :date
      t.text :identifier
      t.text :reference
      t.string :description
      t.integer :type
      t.float :total
      t.boolean :paid

      t.timestamps
    end
  end
end
