# cdp_web_manyo_task

「万葉」課題で使用するRailsアプリケーションのスターターです。

## 動作環境

- Ruby 4.0.5
- Ruby on Rails 8.1.3
- Bundler 4.0.10
- PostgreSQL 18.4
- Node.js 24.18.0
- Yarn 1.22.x

## セットアップ

PostgreSQLを起動してから、次のコマンドを実行してください。

```bash
bundle install
yarn install --frozen-lockfile
bundle exec rails db:prepare
```

## サーバー起動

```bash
bundle exec rails server
```

ブラウザで `http://localhost:3000` を開きます。

## テスト

```bash
RAILS_ENV=test bundle exec rails db:prepare
bundle exec rails test
bundle exec rails test:system
```

## 課題の自己評価

Step 1でRSpec Railsを導入し、モデルspecとシステムspecを作成した後は、次のコマンドで受講生自身のテストと課題要件をまとめて確認できます。

```bash
bin/check step1
bin/check step2
bin/check step3
bin/check step4
bin/check step5
```

対象Stepのコマンドが成功し、push後のGitHub Actionsが成功すれば、そのStepは完了です。評価結果はGitHub ActionsのSummaryにも表示されます。

評価対象と参考・任意項目の区分は、[万葉課題の評価区分](docs/evaluation_criteria.md)を参照してください。

## 環境変数

- `DATABASE_URL`: 接続先データベースをURLで指定する場合に使用します。
- `RAILS_MAX_THREADS`: データベース接続プールとPumaの最大スレッド数です。未指定時は5です。
- `CDP_WEB_MANYO_TASK_DATABASE_PASSWORD`: production環境のPostgreSQLパスワードです。
- `RAILS_MASTER_KEY`: production環境などで暗号化済みcredentialsを読む場合に使用します。
- `MANYO_EVALUATOR_REF`: 使用する評価コードのタグまたはSHAです。通常は変更しません。
- `MANYO_EVALUATOR_PATH`: 評価コード開発時にローカルcheckoutを使用するための任意設定です。
