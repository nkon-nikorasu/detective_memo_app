# DetectiveMemo
## サービス概要
  ミステリ小説の内容を記録整理するためのツールアプリです。
  ミステリ小説内の事件を登録し時系列や登場人物を詳細にまとめることでより物語を楽しむことができます
## このサービスへの思い・作りたい理由
  自分は趣味でミステリー小説をよく読みます。その際によく悩んでいたことがあって
  時系列や登場人物の情報が頭の中でうまく整理できなくなることです。
  ミステリー小説の醍醐味は探偵役の登場人物のように読者自体も推理することだと自分は思っているんですが
  ドラマや映画と違って小説はほとんど全て活字で物事を表現するので読者の想像力任せな部分が多いです。
  そこまで登場人物が多くなければ覚えることはあまり苦ではないのですが登場人物が多い物語や序盤に伏線と思える話題が出ても中盤終盤には忘れてしまったり事件の時系列や各登場人物の時系列が話題になると頭の中でごっちゃになってその後の物語をなんとなく楽しむ形になってしまいます。
  そこの負担をできるだけ取り除く方法があればいいと思ったのがきっかけです。

## ユーザー層について
  - ミステリー小説を好んで読み謎解きが好きな20-40の方
  自分自身がこの層に該当しなおかつwebアプリの使用に抵抗がない年齢層だからです

## サービス利用イメージ
  - ミステリ小説読書中に伏線、登場人物、時系列を任意に登録していく
    - 1.小説内の事件の登録
        事件名及び「殺人」、「密室」、「テロ」などのタグ登録
        事件の概要の記述。
        [![Image from Gyazo](https://i.gyazo.com/cf84e629fea22eee4f0c25606bdef860.png)](https://gyazo.com/cf84e629fea22eee4f0c25606bdef860)
    - 2.書籍登録
        書籍登録画面で該当の書籍を書籍名・著者名等のキーワードで検索し事件記録に紐付けできます。
        [![Image from Gyazo](https://i.gyazo.com/66cbbb79100eeff77154279b846e759e.jpg)](https://gyazo.com/66cbbb79100eeff77154279b846e759e)
    - 3.登場人物の登録
        登場人物登録画面で「性別」、「年齢」、「職業」、「人物説明」各項目を登録できます。
        [![Image from Gyazo](https://i.gyazo.com/ba625cf92929024fffeb46db5b97f6e6.png)](https://gyazo.com/ba625cf92929024fffeb46db5b97f6e6)
        [![Image from Gyazo](https://i.gyazo.com/da0219ecf817e6830de245b131d21f2f.png)](https://gyazo.com/da0219ecf817e6830de245b131d21f2f)
    - ４.登場人物関係の登録
        人物相関図画面で「本人」、「相手」、「関係」、「本人からの印象」、「相手からの印象」各項目を登録できます。登録後、編集後、削除後に下記の人物関係表、人物相関図に即時反映されます。
        [![Image from Gyazo](https://i.gyazo.com/db3a2d2618b22269fe3ca7e4b21ba196.png)](https://gyazo.com/db3a2d2618b22269fe3ca7e4b21ba196)
        [![Image from Gyazo](https://i.gyazo.com/b6357bef4cdd266543f8d0b90e2e0306.png)](https://gyazo.com/b6357bef4cdd266543f8d0b90e2e0306)
    - ５.事件時系列の登録
        事件時系列登録画面で「日時」、「行動・移動」の項目を入力できます。
        [![Image from Gyazo](https://i.gyazo.com/ceb82809aa7fe43e8fc36c1402ffab55.png)](https://gyazo.com/ceb82809aa7fe43e8fc36c1402ffab55)
        [![Image from Gyazo](https://i.gyazo.com/778b94066da6a04450ccd7f3997363a2.png)](https://gyazo.com/778b94066da6a04450ccd7f3997363a2)
    - ６.推理メモ
        推理メモ画面で任意の段階で読者がまとめた情報を整理した上での真相や犯人の予想の記述、タグは「推理」、「伏線」を用意しており、その時点での考察や要点を分けられるようになっています。
        [![Image from Gyazo](https://i.gyazo.com/4b81e1a07103b228386680ab979f2616.png)](https://gyazo.com/4b81e1a07103b228386680ab979f2616)
        [![Image from Gyazo](https://i.gyazo.com/ddf7966ff2f9401db78420f6af2bc46b.png)](https://gyazo.com/ddf7966ff2f9401db78420f6af2bc46b)
  * 基本事件の登録を必須部分にしてそれ以外を任意で登録することで利用者  が負担を感じずに利用できるように意識しています

## 既存サービス
  - サービス名：mac標準のメモアプリ
  - どんなことができるか：日付ごとのメモの分類、段落やフォントの変更

## サービスの差別化ポイント・推しポイント
  - 既存のメモアプリは白紙に自分の書きたいこと記録したいことを自由に記述できるようになっています
  - **既存サービスと比較した強み**
    - ミステリ小説の情報整理ツールとして特化しているので時系列や登場人物のテンプレートが詳細としてみやすくなっています

## 主な機能
- 認証機能
  - サインアップ/ログイン・ログアウト機能
  - google認証
- メモ機能
  - 事件登録
    - 事件名
    - タグ
    - 説明
    - 書籍登録
    - 時系列表
      - 時間、移動場所・行動
    - 登場人物
      - 名前
      - 年齢
      - 性別
      - 職業
      - 人物説明
    - 登場人物関係
      - 本人
      - 相手
      - 関係
      - 本人からの印象
      - 相手からの印象
      - 人物相関図
    - 推理メモ
     - タグ
     - メモ
    　

- 編集
- 削除
 
## 今後取り入れてみたい機能・展開（未定）
 - 感想投稿共有機能
 - 登場人物自体に時系列モデルを持たせる。
 * このアプリはどうしても入力が多くなってしまうのでAIによる予測変換などを取り入れたい

## 使用技術

- フレームワーク：
  - バックエンド:ruby on rails
  - フロントエンド:Hotwire
- DB：PostgreSQL
- cssフレームワーク: Tailwind
- デプロイ先：Render
- 使用予定ライブラリ：device,kaminari,acts_as_list,mermaid.js,googlebooksapi
### 画面遷移図
Figma：https://www.figma.com/design/qLKM0gSeoalkGSAJpm51tw/%E7%84%A1%E9%A1%8C?node-id=0-1&t=M3eWzAyUhTCbeBFr-1

### 本サービスの概要（700文字以内）
推理小説のメモアプリです事件名という形で枠組みを作成しその中で事件の概要や時系列レコードや登場人物、人登場物関係を編集で加える形で作成し詳細画面でそのまとめた情報に対する伏線や自分自身の推理をメモで記載します
### READMEに記載した機能
- [O] ユーザー登録機能
- [O] ログイン機能
- [O] パスワード変更機能
- [O] 事件作成機能
- [O] 事件詳細機能
- [O] 事件編集機能
- [O] 事件削除機能
- [O] 時系列作成機能
- [O] 時系列編集機能
- [O] 時系列削除機能
- [O] 登場人物作成機能
- [O] 登場人物編集機能
- [O] 登場人物削除機能
- [O] メモ作成機能
- [O] メモ編集機能
- [O] メモ削除機能

### 未ログインでも閲覧または利用できるページ
topページ
パスワード変更ページ
利用規約ページ
プライバシーポリシーページ

### メールアドレス・パスワード変更確認項目
- [] メールアドレス
- [O] パスワード

### ER図
[![Image from Gyazo](https://i.gyazo.com/dd52d903fdfd1ea7c6987437ebe0fe0e.png)](https://gyazo.com/dd52d903fdfd1ea7c6987437ebe0fe0e)
### 本サービスの概要（700文字以内）
このアプリはミステリー小説を読む20~40代の読者向けに作ったアプリです事件の内容や時系列、そこに出てくる登場人物を記録していきそこから物語に出てきた伏線や自らの推理などをメモしていくアプリになります。
### MVPで実装する予定の機能
- 機能①事件登録機能、編集、削除
- 機能②事件時系列登録機能、編集、削除
- 機能③登場人物登録機能、編集、削除
- 機能④メモ登録機能、編集、削除
- 機能⑤ユーザー機能(新規登録、ログイン、ログアウト)
## テーブル詳細
### usersテーブル(ユーザー情報)
- email(string)ユーザーのメールアドレス
- encrypted_password(string)ログイン用パスワード
### Incidentsテーブル(事件情報)
- incident_id(integer)ユーザーid(外部キー)
- book_id(bigint)書籍id(外部キー)
- name(string)事件名
- tag(integer)タグ
- body(text)事件説明
### IncidentTimesTableテーブル(事件時系列)
- incident_id(integer)事件id(外部キー)
- year(integer)(null)西暦値
- month(integer)(null)月値
- date(integer)(null)日付値
- hour(integer)(null)時間値
- minuts(integer)(null)分値
- second(integer)(null)秒値
- body(string)時系列説明
- position(integer)並べ替え用
### CharactersTableテーブル(登場人物)
- incident_id(integer)事件id(外部キー)
- name(string)人物名前
- gender(integer)人物性別
- age(integer)人物年齢
- role(string)人物職業
- body(text)人物説明
### CharacterRelationshipsTableテーブル(登場人物関係)
- source_character_id(bigint)登場人物id(外部キー)
- target_character_id(bigint)登場人物id(外部キー)
- relation(string)関係
- source_to_target_impression(string)本人からの印象
- target_to_source_impression(string)相手からの印象
### MemosTableテーブル(メモ)
- incident_id(integer)事件id(外部キー)
- tag(integer)タグ
- body(text)メモ内容
### Booksテーブル(書籍)
- google_books_id(string)書籍id
- title(string)書籍名
- authors(string)著者名
- thumbnail_url(string)画像url
### ER図の注意点
- [o] 最新のER図スクリーンショットがPRに掲載されているか
- [o] テーブル名は複数形になっているか
- [o] カラムの型は記載されているか
- [o] 外部キーは適切か
- [o] リレーションは正しく描かれているか
- [o] 多対多の関係になっていないか
- [o] STIを使用していないか
- [o] postsテーブルに post_name のような命名をしていないか
