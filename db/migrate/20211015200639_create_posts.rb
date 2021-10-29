class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false, default: ""
      t.text :content, null: false, default: ""
      t.boolean :visible, null: false, default: false

      t.timestamps
    end
  end
end
