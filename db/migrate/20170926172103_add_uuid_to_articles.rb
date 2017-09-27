class AddUuidToArticles < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'uuid-ossp'
    add_column :articles, :uuid, :uuid, default: 'uuid_generate_v4()', null: false, index: true
  end
end
