class CreateToDos < ActiveRecord::Migration
  def change
    create_table :to_dos do |t|
    	t.integer :content_id
    	t.integer :idx, :default => 0
    	t.string :title
    	t.integer :state, :default => 0
      t.timestamps
    end
  end
end
