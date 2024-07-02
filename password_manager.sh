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

# Get Password が入力された場合 => 入力値が"Get Password"と等しい
elif [ "$choice" = "Get Password" ]; then
	echo "サービス名を入力してください:"
	# 入力されたサービス名を変数に格納
	read get_service_name

	## サービス名が保存されていた場合
	if [ "$get_service_name" = "yahoo" ]; then
		echo "サービス名:hoge"
		echo "ユーザー名:fuga"
		echo "パスワード:piyo"
	## サービス名が保存されていなかった場合
	else
	## get_service_nameと保管庫txtから「"先頭〜":までの文字列を検索したものが不一致の場合
		echo "そのサービスは登録されていません。"
	fi
else
	# Add Password/Get Password/Exit 以外が入力された場合
	echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。"
fi





# Exit が入力された場合
echo "Thank you!"
## プログラムが終了


