# ベースとなるイメージを指定（DockerHubからダウンロードされる）
# Rubyの軽量環境
FROM ruby:3.2.2-alpine

# 利用可能なパッケージリストのリストを更新するコマンドを実行
RUN apk update

# パッケージをインストールするコマンドを実行
# tzdata = タイムゾーンデータ
RUN apk add g++ make mysql-dev tzdata

RUN apk add --no-cache gcompat

# コンテナを起動したときの作業作業ディレクトリを/appにする。
WORKDIR /app  

# PC上のGemfileを . (/app)にコピー
COPY Gemfile .

# bundle installでGemfileに記述されているgemをインストール
RUN bundle install