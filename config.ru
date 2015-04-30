# Require config/environment.rb
require ::File.expand_path('../config/environment',  __FILE__)

set :app_file, __FILE__

run Sinatra::Application

set :database, ENV['DATABASE_URL'] || 'postgres://xfkibatbqicwts:GvdqqPnud7032OZ2l_qOcaM-ag@ec2-107-22-182-206.compute-1.amazonaws.com:5432/d663creaej94iu'
