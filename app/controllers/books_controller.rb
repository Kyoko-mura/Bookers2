class BooksController < ApplicationController
    before_action :authenticate_user!
    def index
      @books = Book.all
      @book = Book.new
      @user = User.find(current_user.id)
      @users = User.all
    end

    def create
      flash[:notice] = "You have creatad book successfully."
    	@book = Book.new(book_params)
      @user = User.find(current_user.id)
      @book.user_id = current_user.id

        if @book.save
          redirect_to book_path(@book.id)
        else
          @books = Book.all
          render :index
        end
    end

    def show
    	@book = Book.find(params[:id])
      @newbook = Book.new
      @user = User.find(current_user.id)
      @author = User.find(@book.user_id)
    end

    def edit
     flash[:notice] = "You have updated book successfully."
       @book = Book.find(params[:id])
       if current_user.id != @book.user.id
        redirect_to books_path
      end
    end

    def update
       flash[:notice] = "You have updated book successfully."
       @book = Book.find(params[:id])
       if @book.update(book_params)
       redirect_to book_path(@book.id)
       else
        render :edit
       end
    end

    def destroy
  	 	 @book = Book.find(params[:id])
  	 	 @book.destroy
  		 redirect_to books_path
	  end

  private
  def book_params
      params.require(:book).permit(:title, :body)
  end

end
