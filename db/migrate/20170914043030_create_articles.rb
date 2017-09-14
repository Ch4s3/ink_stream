class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :link
      t.date :date
      t.references :publication, foreign_key: true

      t.timestamps
    end
    add_index :articles, :title
  end
end
