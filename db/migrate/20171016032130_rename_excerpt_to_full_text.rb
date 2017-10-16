class RenameExcerptToFullText < ActiveRecord::Migration[5.1]
  def change
    rename_column :articles, :excerpt, :full_text
  end
end
