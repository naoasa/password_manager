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
	# パスワード保管庫内からサービス名を元に検索し、文字列の:を改行に置換して整形
	formatted_data="$(cat password_storage.txt | grep "^$get_service_name:" | sed 's/:/\n/g')"

	### $formatted_dataの中身
	## サービス名(1行目)
	## ユーザー名(2行目)
	## パスワード(3行目)

	service_name=$(echo "$formatted_data" | sed -n 1p) # 整形データの1行目
	user_name=$(echo "$formatted_data" | sed -n 2p) # 整形データの2行目
	password=$(echo "$formatted_data" | sed -n 3p) # 整形データの3行目

	if [ "$formatted_data" ]; then # データが存在するかの判定
		echo "サービス名:$service_name"
		echo "ユーザー名:$user_name"
		echo "パスワード:$password"
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


