class CreatePublications < ActiveRecord::Migration[5.1]
  def change
    create_table :publications do |t|
      t.string :name
      t.string :site
      t.text :description

      t.timestamps
    end
  end
end
