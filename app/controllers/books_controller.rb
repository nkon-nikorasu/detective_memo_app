class BooksController < ApplicationController
  def search
    # params[:q] をGoogleBooksService.searchに渡す
    @books = GoogleBooksService.search(params[:q])
  end
end
