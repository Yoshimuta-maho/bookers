class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to @book, notice:"Book was successfully created" #AIメンターに質問して真似た記載をした部分。""の中身が同じものが二つあるが、どちらか消去しても大丈夫なのか
    else
      @books = Book.all
      flash.now[:notice] = "errors prohibited this book from being saved:"
      render :index #質問フォーム作成時、エラーが出ていた部分。『render :new』としているとフォームに記載したエラーが出てきた
    end
  end

  def index
    @book = Book.new
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book =Book.find(params[:id])
  end

  def update
    book =Book.find(params[:id])
    book.update(book_params)
    redirect_to book_path(book.id)
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
