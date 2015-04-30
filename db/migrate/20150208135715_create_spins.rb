class CreateSpins < ActiveRecord::Migration
  def change

  	create_table :spins do |t|
      t.string :name
      t.string :column
      t.string :row
      t.string :approval
      t.string :reason
      t.integer :shoot_id
      
   
  	end
  end
end
