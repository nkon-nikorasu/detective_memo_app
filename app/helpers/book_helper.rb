module BookHelper
  def google_book_thumbnail(google_book)
     google_book[:thumbnail].presence || "notimage.png"
  end
end
