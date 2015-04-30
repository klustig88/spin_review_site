class Spin < ActiveRecord::Base
  # Remember to create a migration!

  belongs_to :shoot
  has_many :comments
  has_many :stills

end


