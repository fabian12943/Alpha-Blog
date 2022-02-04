class AddTagColorToCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :tag_color, :string, default: 'a9a9a9', null: false
  end
end
