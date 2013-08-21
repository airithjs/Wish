class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
    	t.integer :content_id
    	t.datetime :s_date
    	t.datetime :e_date
      t.string :persion
    	t.integer :total_todo, :default => 0
    	t.integer :finish_todo, :default => 0
      t.integer :state, :default => 0
      t.timestamps
    end
  end
end
