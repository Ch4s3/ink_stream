class AddScoreToPublications < ActiveRecord::Migration[5.1]
  def change
    add_column :publications, :score, :float
  end
end
