class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.references :post, null: false, foreign_key: true
      t.string :comment

      t.timestamps
    end
  end
end
