class AddExcerptToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :excerpt, :text
  end
end
