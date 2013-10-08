class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
    t.references :page
    t.string "name"
    t.integer "position"
    t.boolean "visable", :default => false
    t.string "content"

      t.timestamps
    end
    add_index("sections", "page_id")
  end

  def self.down
    drop_table :sections
  end
  
end
