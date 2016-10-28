class AddSlugToServices < ActiveRecord::Migration[5.0]
  def change
    add_column :services, :slug, :string, default: "", null: false

    add_index :services, :slug, unique: true
  end
end
