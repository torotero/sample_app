class UsersController < ApplicationController


  before_action :logged_in_user,only: [:edit, :update, :index, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy



  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end




  def edit
    @user= User.find(params[:id])
  end

  def index
  #  @users = User.all
  @users = User.paginate(page: params[:page])
  end

  
  def show
  	@user= User.find(params[:id])
  	#debugger
  	
  end

  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # something todo

      log_in @user
      flash[:success] = "Welcome to Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end



  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end






### dimasukin ke before buat authorisasi
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "please log in."
      redirect_to login_url
     end
  end


### memastikan user x hanya update miliknya sendiri
### dimasukin ke before action 
def correct_user
  @user = User.find(params[:id])
  redirect_to(root_url) unless @user == current_user
end






  private

  def user_params
    params.require(:user).permit(:name, :email,:password,:password_confirmation)
  end


  #memastikan admin
  def admin_user
      redirect_to(root_url) unless current_user.admin?
  end




end
