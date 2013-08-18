class CreateWikis < ActiveRecord::Migration
  def change
    create_table :wikis do |t|
    	t.integer :content_id
    	t.integer :rev, :default => 0
    	t.text :text
    	t.string :editor
    	t.boolean :is_last, :default => true
      t.timestamps
    end
  end
end
