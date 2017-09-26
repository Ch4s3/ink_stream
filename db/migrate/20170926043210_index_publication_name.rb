class IndexPublicationName < ActiveRecord::Migration[5.1]
  def change
    add_index :publications, :name
  end
end
