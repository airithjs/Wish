class CreateContentInfos < ActiveRecord::Migration
  def change
    create_table :content_infos do |t|
    	t.string :title
    	t.integer :last_rev , :default => 0
    	t.string :tag
    	t.string :category
    	t.string :content_type
      t.integer :parent
      t.timestamps
    end
  end
end
