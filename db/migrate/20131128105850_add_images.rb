class AddImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.references :page
      t.string "name"
      t.integer "position"
      t.boolean "visible", :default => false
      t.string "url"
      

      t.timestamps
    end
    add_index("images", "page_id")
  end
end
