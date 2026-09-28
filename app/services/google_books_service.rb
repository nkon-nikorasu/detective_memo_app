class GoogleBooksService
  class Error < StandardError; end
  BASE_URL = "https://www.googleapis.com/books/v1/volumes"

  def self.search(query, search_type)
    search_query =
      if search_type == "author"
        "inauthor:#{query}"
      else
        "intitle:#{query}"
      end

    response = Faraday.get(
      BASE_URL,
      {
        q: search_query,
        key: ENV["GOOGLE_BOOKS_API_KEY"],
        maxResults: 20
      }
    )

    data = JSON.parse(response.body)

    data.fetch("items", []).map do |book|
      info = book["volumeInfo"]

      {
        id: book["id"],
        title: info["title"],
        authors: info["authors"],
        thumbnail: info.dig("imageLinks", "thumbnail")&.sub("http://", "https://")
      }
    end
  end

  def self.find(google_books_id)
    Rails.logger.debug "Google Books API find called"
    response = Faraday.get(
      "#{BASE_URL}/#{google_books_id}",
      {
        key: ENV["GOOGLE_BOOKS_API_KEY"]
      }
    )

    raise Error, "Google Books APIの取得に失敗しました" unless response.success?

    data = JSON.parse(response.body)
    info = data["volumeInfo"]

    {
      id: data["id"],
      title: info["title"],
      authors: info["authors"] || [],
      thumbnail: info.dig("imageLinks", "thumbnail")&.sub("http://", "https://")
    }
  end
end
