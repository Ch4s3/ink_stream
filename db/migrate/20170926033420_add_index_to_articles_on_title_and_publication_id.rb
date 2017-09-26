class AddIndexToArticlesOnTitleAndPublicationId < ActiveRecord::Migration[5.1]
  def change
    add_index :articles, [:title, :publication_id]
  end
end
