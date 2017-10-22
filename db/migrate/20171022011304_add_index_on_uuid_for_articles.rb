class AddIndexOnUuidForArticles < ActiveRecord::Migration[5.1]
  def change
    add_index :articles, :uuid
  end
end
