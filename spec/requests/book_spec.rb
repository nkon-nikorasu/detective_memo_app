require 'rails_helper'

RSpec.describe "Books", type: :request do
  let(:user) { create(:user) }
  let(:incident) { create(:incident, user: user) }

  before do
    sign_in user
  end

  describe "POST /incidents/:incident_id/books" do
    let(:google_books_id) { "zlPwzgEACAAJ" }

    let(:google_book) do
      {
        id: google_books_id,
        title: "爆弾",
        authors: ["呉勝浩"],
        thumbnail: "https://books.google.com/example.jpg"
      }
    end

    context "Bookがまだ存在しない場合" do
      before do
        allow(GoogleBooksService)
          .to receive(:find)
          .with(google_books_id)
          .and_return(google_book)
      end

      it "Bookを作成する" do
        expect {
          post incident_books_path(incident),
               params: { google_books_id: google_books_id }
        }.to change(Book, :count).by(1)
      end

      it "作成したBookをIncidentに関連付ける" do
        post incident_books_path(incident),
             params: { google_books_id: google_books_id }

        expect(incident.reload.book.google_books_id)
          .to eq(google_books_id)
      end
    end

    context "同じgoogle_books_idのBookが存在する場合" do
      let!(:book) do
        create(
          :book,
          google_books_id: google_books_id,
          title: "爆弾",
          authors: ["呉勝浩"]
        )
      end

      it "Bookを新しく作成しない" do
        expect {
          post incident_books_path(incident),
              params: { google_books_id: google_books_id }
        }.not_to change(Book, :count)
      end

      it "Google Books APIを呼ばない" do
        expect(GoogleBooksService).not_to receive(:find)

        post incident_books_path(incident),
            params: { google_books_id: google_books_id }
      end

      it "既存のBookをIncidentに関連付ける" do
        post incident_books_path(incident),
            params: { google_books_id: google_books_id }

        expect(incident.reload.book).to eq(book)
      end
    end
  end
end
