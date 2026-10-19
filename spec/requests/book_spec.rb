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
        authors: [ "呉勝浩" ],
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
          authors: [ "呉勝浩" ]
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

    context "Google Books APIの取得に失敗した場合" do
      before do
        allow(GoogleBooksService)
          .to receive(:find)
          .with(google_books_id)
          .and_raise(GoogleBooksService::Error)
      end

      it "書籍検索画面にリダイレクトする" do
        post incident_books_path(incident),
            params: { google_books_id: google_books_id }

        expect(response).to redirect_to(search_incident_books_path(incident))
      end

      it "エラーメッセージを表示する" do
        post incident_books_path(incident),
            params: { google_books_id: google_books_id }

        expect(flash[:alert]).to eq(
          I18n.t("defaults.flash_message.book_api_error")
        )
      end
    end
  end

  describe "GET /incidents/:incident_id/books/autocomplete" do
    let(:books) do
      [
        {
          id: "book1",
          title: "容疑者Xの献身",
          authors: [ "東野圭吾" ],
          thumbnail: nil
        },
        {
          id: "book2",
          title: "白夜行",
          authors: [ "東野圭吾" ],
          thumbnail: nil
        }
      ]
    end

    before do
      allow(GoogleBooksService).to receive(:search).and_return(books)
    end

    context "検索文字が2文字以上の場合" do
      it "GoogleBooksServiceを検索キーワードで呼び出す" do
        get autocomplete_incident_books_path(incident),
            params: { q: "容疑者" }

        expect(GoogleBooksService)
          .to have_received(:search)
          .with("容疑者")

        expect(response).to have_http_status(:ok)
      end

      it "本のタイトルを候補として表示する" do
        get autocomplete_incident_books_path(incident),
            params: { q: "容疑者" }

        expect(response.body).to include("容疑者Xの献身")
      end

      it "検索候補に書籍タイトルと著者名を表示する" do
        get autocomplete_incident_books_path(incident),
            params: { q: "東野" }

        expect(response.body).to include("容疑者Xの献身")
        expect(response.body).to include("東野圭吾")
      end
    end

    context "検索文字が1文字の場合" do
      it "GoogleBooksServiceを呼び出さない" do
        get autocomplete_incident_books_path(incident),
            params: { q: "東" }

        expect(GoogleBooksService).not_to have_received(:search)
        expect(response).to have_http_status(:ok)
      end
    end

    context "Google Books APIの取得に失敗した場合" do
      before do
        allow(GoogleBooksService)
          .to receive(:search)
          .and_raise(GoogleBooksService::Error)
      end

      it "空の候補を返す" do
        get autocomplete_incident_books_path(incident),
            params: { q: "容疑者" }

        expect(response).to have_http_status(:ok)
        expect(response.body).not_to include('role="option"')
      end
    end
  end

  describe "GET /incidents/:incident_id/books/search" do
    let(:books) do
      [
        {
          id: "book1",
          title: "容疑者Xの献身",
          authors: [ "東野圭吾" ],
          thumbnail: nil
        }
      ]
    end

    before do
      allow(GoogleBooksService).to receive(:search).and_return(books)
    end

    it "検索キーワードをGoogleBooksServiceに渡す" do
      get search_incident_books_path(incident),
          params: { search: "容疑者" }

      expect(GoogleBooksService)
        .to have_received(:search)
        .with("容疑者")

      expect(response).to have_http_status(:ok)
    end

    it "取得した書籍を検索結果に表示する" do
      get search_incident_books_path(incident),
          params: { search: "容疑者" }

      expect(response.body).to include("容疑者Xの献身")
    end
  end
end
