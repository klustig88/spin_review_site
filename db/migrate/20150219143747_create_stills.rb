class CreateStills < ActiveRecord::Migration
  def change

  	create_table :stills do |t|
	  	t.string :name
	  	t.string :approval
	  	t.string :spinname

	  	
  	end
  end
end
