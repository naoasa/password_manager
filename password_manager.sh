#!/bin/bash

echo "パスワードマネージャーへようこそ！"

echo "サービス名を入力してください:"
# サービス名の受け取り
read service_name

echo "ユーザー名を入力してください:"
# ユーザー名の受け取り
read user_name

echo "パスワードを入力してください:"
# パスワードの受け取り
read password

# 受け取り値を標準出力でファイルに追記
echo "$service_name:$user_name:$password" 1>> password_storage.txt

# 入力が完了したら
echo "Thank you!"
