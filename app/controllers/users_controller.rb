class UsersController < ApplicationController
    before_action :authenticate_user!
  def index
  	@users = User.all
  	@book = Book.new
    @user = User.find(current_user.id)
  end

  def show
  	@user = User.find(params[:id])
    @books = @user.books.page(params[:page]).reverse_order
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
      if current_user.id != @user.id
        redirect_to user_path(current_user.id)
      end
  end

  def update
  	 flash[:notice] = "You have updated user successfully."
	    @user = User.find(params[:id])
	    if @user.update(user_params)
	      redirect_to user_path(@user.id)
      else
        render :edit
      end
	end
	private
	def user_params
	    params.require(:user).permit(:name, :profile_image, :introduction)
	end

end
