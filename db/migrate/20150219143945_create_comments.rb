class CreateComments < ActiveRecord::Migration
  def change

  	create_table :comments do |t|

	  	t.string :spinid
	  	t.string :username
	  	t.string :text
	  	
	end
  end
end
