class CreateShoots < ActiveRecord::Migration
  def change

  	create_table :shoots do |t|
	  	t.string :name
	  	t.string :description
	  	t.integer :client_id

  end
  	
  end
end
