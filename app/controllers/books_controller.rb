class BooksController < ApplicationController
  before_action :set_incident

  def search
    @books = if params[:search].present?
              GoogleBooksService.search(params[:search], params[:search_type])
    else
              []
    end
  end

  def autocomplete
    @books = if params[:q].present? && params[:q].length >= 2
      GoogleBooksService.search(params[:q], params[:search_type])
    else
      []
    end

    if params[:search_type] == "author"
      @authors = @books.flat_map { |book| book[:authors] || [] }.uniq
    end
    render layout: false
  end

  def create
    google_books_id = book_params[:google_books_id]
    book = Book.find_by(google_books_id: google_books_id)
    unless book
      google_book = GoogleBooksService.find(google_books_id)

      book = Book.create_or_find_by!(google_books_id: google_book[:id]) do |new_book|
        new_book.title = google_book[:title]
        new_book.authors = google_book[:authors]
        new_book.thumbnail_url = google_book[:thumbnail]
      end
    end

    @incident.update!(book: book)

    redirect_to incident_path(@incident), notice: t("defaults.flash_message.book_created")
  rescue GoogleBooksService::Error
    redirect_to search_incident_books_path(@incident),
                alert: t("defaults.flash_message.book_api_error")
  end

  private

  def set_incident
    @incident = current_user.incidents.find(params[:incident_id])
  end

  def book_params
    params.permit(:google_books_id)
  end
end
