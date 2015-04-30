set :sessions, true
set :logging, true
set :dump_errors, false
set :some_custom_option, false

# User/Login Routing   ------------------------------------------------------------------------------------------------------------------------------------



get '/' do
  erb :welcome
   
end

post '/login' do
  @user = User.find_by_name(params[:user][:name])
  if @user.try(:authenticate, params[:user][:password])
    erb :user
  else
    flash[:error] = "Username or Password are incorrect, please try again."
  end
end


#Displaying Spins   ------------------------------------------------------------------------------------------------------------------------------------




get '/spins/*' do

  @spins = Spin.all.size
  

erb :spins
  # @number = params[:splat]


end

post '/spins/*/approval' do

@spinset = Spin.find_by_id(params[:splat].first)
@spinset.approval = params[:approval]
@spinset.save
 
  @spins = Spin.all.size

erb :spins




end


post '/spins/*/reason' do

@spinset = Spin.find_by_id(params[:splat].first)
@spinset.reason = params[:reason]
@spinset.save
 
  @spins = Spin.all.size

erb :spins




end






# Client Creation ----------------------------------------------------------------------------------------------------------------------------------------


get '/create/client' do


  erb :client_creation

end

post '/create/client' do

  @client = Client.new(name: params[:name], contact: params[:contact], phone: params[:phone])
  @client.save

  erb :client_creation

end
  


# Shoot Creation ----------------------------------------------------------------------------------------------------------------------------------------

get '/create/shoot' do


  erb :shoot_creation

end


post '/create/shoot' do



  @client = Client.find_by_name(params[:entry])

  @shoot = Shoot.new(name: params[:shoot_name], description: params[:description], client_id: @client.id)
  @shoot.save


   Dir.foreach('./public/img') do |item|
  next if item == '.' or item == '..' or item == '.DS_Store' or item == 'Thumbs.db'

    @spin = Spin.new(name: item, shoot_id: @shoot.id) 
    @spin.save 

  end

  @spins = Spin.all
  @spins.each do |image|

    @array = 0

  Dir.foreach('./public/img/' + image.name) do |number|
  next if number == '.' or number == '..' or number == '.DS_Store' or number == 'Thumbs.db'

    @array += 1
  end

    if @array == 144
     
      @column = "24"
      @row = "3"

    elsif @array == 96

      @column = "24"
      @row = "2"

    else

      @column = "24"
      @row = "1"
    end

    image.row = @row
    image.column = @column

    image.save
  end

    Dir.foreach('./public/stills/') do |item|
  next if item == '.' or item == '..' or item == '.DS_Store' or item == 'Thumbs.db'




  Dir.foreach('./public/stills/' + item) do |s|
  next if s == '.' or s == '..' or s == '.DS_Store' or s == 'Thumbs.db'

    @still = Still.new(name: s, spinname: item)
    @still.save
  end
end


 
  erb :success


end

# Gallery Navigation Links ---------------------------------------------------------------------------------------------------------------------------------------


get '/approveditems/*' do

  @totalsize =  Spin.where(:approval => "[\"approved\"]").size

  erb :approved_items

end



get '/rejecteditems/*' do

  @totalsize =  Spin.where(:approval => "[\"rejected\"]").size

  erb :rejected_items

end



get '/notreviewed/*' do

  @totalsize =  Spin.where(:approval => nil ).size


  erb :notreviewed

end





get '/gallery' do

 

  erb :gallery

end

get '/find' do

  erb :find

end


post '/find' do

  @product = Spin.find_by_name(params[:productcode])

  if @product == nil

     erb :errorfind



  else 

        erb :found
   
  end

end 


#  Comment Routing ----------------------------------------------------------------------------------------------------------------------------------------------


post '/spins/*/comments' do

 @text = params['comment'].first.strip

@spinset = Spin.find_by_id(params[:splat].first)
@comment = Comment.new(spinid: @spinset.id, text: @text )
@comment.save
 
  @spins = Spin.all.size

erb :spins




end





# Admin Routing -------------------------------------------------------------------------------------------------------------------------------------------------

get '/admin' do

	erb :admin_login

end

post '/admin/login' do
  @admin = Admin.find_by_name(params[:admin][:name])
  if @admin.try(:authenticate, params[:admin][:password])
    erb :admin
  else
    flash[:error] = "Username or Password are incorrect, please try again."
  end
end




