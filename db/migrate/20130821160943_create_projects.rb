class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
    	t.string :manager
      t.timestamps
    end
  end
end
