class CreateRawFiles < ActiveRecord::Migration
  def change
    create_table :raw_files do |t|
    	t.string :comment
    	t.integer :content_id
    	t.string :uploader
      t.timestamps
    end
  end
end
