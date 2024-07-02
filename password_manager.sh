#!/bin/bash

echo "パスワードマネージャーへようこそ！"

echo "次の選択肢から入力してください(Add Password/Get Password/Exit):"
# 入力値の格納
read choice

# Add Password が入力された場合 => 入力値が"Add Password"と等しい
if [ "$choice" = "Add Password" ]; then
	# Add Password Menu
	echo "サービス名を入力してください:" # サービス名の受け取り
	read service_name
	echo "ユーザー名を入力してください:" # ユーザー名の受け取り
	read user_name
	echo "パスワードを入力してください:" # パスワードの受け取り
	read password
	# 受け取り値を標準出力でファイルに追記
	echo "$service_name:$user_name:$password" 1>> password_storage.txt
	# 入力が完了したら
	echo "パスワードの追加は成功しました。"
else
	# Add Password/Get Password/Exit 以外が入力された場合
	echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。"
fi



# Get Password が入力された場合

echo "サービス名を入力してください:"

## サービス名が保存されていなかった場合
echo "そのサービスは登録されていません。"
## サービス名が保存されていた場合
echo "サービス名:hoge"
echo "ユーザー名:fuga"
echo "パスワード:piyo"


# Exit が入力された場合
echo "Thank you!"
## プログラムが終了


