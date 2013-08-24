class CreateAttentionContents < ActiveRecord::Migration
  def change
    create_table :attention_contents do |t|
    	t.string :userid
    	t.integer :content_id
    	t.integer :attention_type, :default => 0
      t.timestamps
    end
    add_index :attention_contents, :userid
    add_index :attention_contents, :content_id
  end
end
