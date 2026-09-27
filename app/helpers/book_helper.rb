module BookHelper
  def google_book_thumbnail(google_book)
    google_book[:thumbnail].presence || "notimage.png"
  end

  def incident_book_thumbnail(incident)
    incident.book.thumbnail_url.presence || "notimage.png"
  end

  def incident_book_authors(incident)
    incident.book.authors.presence&.join("、") || "著者不明"
  end
end
