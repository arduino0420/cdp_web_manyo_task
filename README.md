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

## 環境変数

- `DATABASE_URL`: 接続先データベースをURLで指定する場合に使用します。
- `RAILS_MAX_THREADS`: データベース接続プールとPumaの最大スレッド数です。未指定時は5です。
- `CDP_WEB_MANYO_TASK_DATABASE_PASSWORD`: production環境のPostgreSQLパスワードです。
- `RAILS_MASTER_KEY`: production環境などで暗号化済みcredentialsを読む場合に使用します。
