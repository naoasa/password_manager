#!/bin/bash

echo "パスワードマネージャーへようこそ！"

# GitHubからクローン後の.txtのみがある状態への対応(.txt => .gpg に暗号化)
if [ -e password_storage.txt ]; then # .txtファイルが存在する場合
	echo "パスワード暗号化のためのパスフレーズを入力してください"
	sleep 2s # 2秒待機
	gpg -c password_storage.txt # .txtと.gpgがある状態になる
	rm password_storage.txt # .gpgのみがある状態になる
fi

## 以下のコードは、password_storage.txt.gpgファイルが存在する場合の処理を想定

# while文(入力値がExitではない間、ループ)
while [ "$choice" != "Exit" ]

do # ループ開始

	echo "次の選択肢から入力してください(Add Password/Get Password/Exit):"
	read choice # 入力値の格納

	# Exit が入力された場合(入力値が"Exit"と等しい)
	if [ "$choice" = "Exit" ]; then
		: # 処理なし => while文が終了

	# Add Password が入力された場合(入力値が"Add Password"と等しい)
	elif [ "$choice" = "Add Password" ]; then
		# Add Password Menu
		echo "サービス名を入力してください:" # サービス名の受け取り
		read service_name
		echo "ユーザー名を入力してください:" # ユーザー名の受け取り
		read user_name
		echo "パスワードを入力してください:" # パスワードの受け取り
		read password
		# ファイルを復号化
		gpg password_storage.txt.gpg # .txtと.gpgがある状態になる
		# 復号化前のファイルを削除
		rm password_storage.txt.gpg # .txtのみがある状態になる
		# 受け取り値を標準出力でテキストファイルに追記
		echo "$service_name:$user_name:$password" 1>> password_storage.txt
		# テキストファイルを暗号化
		gpg -c password_storage.txt # .txtと.gpgがある状態になる
		# 暗号化前のテキストファイルを削除
		rm password_storage.txt # .gpgのみがある状態になる
		# 入力が完了したら
		echo "パスワードの追加は成功しました。"

	# Get Password が入力された場合 => 入力値が"Get Password"と等しい
	elif [ "$choice" = "Get Password" ]; then
		echo "サービス名を入力してください:"
		# 入力されたサービス名を変数に格納
		read get_service_name

		# 最初は.gpgのみがある状態なので、複合化をして.txtにする必要がある
		gpg password_storage.txt.gpg # .gpgと.txtがある状態になる
		rm password_storage.txt.gpg # .txtのみがある状態になる

		# パスワード保管庫内からサービス名を元に検索し、文字列の:を改行に置換して整形
		formatted_data="$(cat password_storage.txt | grep "^$get_service_name:" | sed 's/:/\n/g')"

		### $formatted_dataの中身
		## サービス名(1行目)
		## ユーザー名(2行目)
		## パスワード(3行目)

		service_name=$(echo "$formatted_data" | sed -n 1p) # 整形データの1行目
		user_name=$(echo "$formatted_data" | sed -n 2p) # 整形データの2行目
		password=$(echo "$formatted_data" | sed -n 3p) # 整形データの3行目

		## サービス名が保存されていた場合
		if [ "$get_service_name" = "$service_name" ]; then # データが存在するかの判定(入力されたサービス名と保管庫のサービス名が一致)
			echo "サービス名:$service_name"
			echo "ユーザー名:$user_name"
			echo "パスワード:$password"
		## サービス名が保存されていなかった場合
		else
		## get_service_nameと保管庫txtから「"先頭〜":までの文字列を検索したものが不一致の場合
			echo "そのサービスは登録されていません。"
		fi

		# .txtのみがある状態なので、暗号化をする必要がある
		gpg -c password_storage.txt # .txtと.gpgがある状態
		rm password_storage.txt # .gpgのみがある状態

	else # 例外(意図しない値が入力された場合)
		# Add Password/Get Password/Exit 以外が入力された場合
		echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。"
	fi

done # ループ終了(Exitが入力されたということ)

# Exit が入力された場合
echo "Thank you!"
## プログラムが終了
