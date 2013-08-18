class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
    	t.integer :content_id
    	t.integer :rev
    	t.string :comment
    	t.string :editor
      t.timestamps
    end
  end
end
