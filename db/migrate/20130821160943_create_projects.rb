class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
    	t.integer :content_id
    	t.string :manager
    	t.integer :total_task ,:default => 0
    	t.integer :finish_task ,:default => 0
      t.timestamps
    end
  end
end
