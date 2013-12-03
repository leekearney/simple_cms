class CreateSections < ActiveRecord::Migration
    def change
    create_table :sections do |t|
      t.references :page
      t.string "name"
      t.integer "position"
      t.boolean "visible", :default => false
      t.string "content"
      t.string "content_type"

      t.timestamps
    end
    add_index("sections", "page_id")
  end

  
end
