require "rails_helper"

RSpec.describe GoogleBooksService do
  describe ".find" do
    let(:google_books_id) { "zlPwzgEACAAJ" }

    let(:response_body) do
      {
        id: google_books_id,
        volumeInfo: {
          title: "爆弾",
          authors: ["呉勝浩"],
          imageLinks: {
            thumbnail: "http://books.google.com/example.jpg"
          }
        }
      }.to_json
    end

    before do
      response = instance_double(
        Faraday::Response,
        body: response_body
      )

      allow(Faraday).to receive(:get).and_return(response)
    end

    it "Google Booksの書籍情報を整形して返す" do
      result = described_class.find(google_books_id)

      expect(result).to eq(
        {
          id: google_books_id,
          title: "爆弾",
          authors: ["呉勝浩"],
          thumbnail: "https://books.google.com/example.jpg"
        }
      )
    end
  end
end
