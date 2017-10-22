class AddIndexOnAnnotationsUpdatedAtArticleId < ActiveRecord::Migration[5.1]
  def change
    add_index :annotations, [:article_id, :updated_at]
  end
end
