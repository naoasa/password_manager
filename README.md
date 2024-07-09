# パスワードマネージャー

## 説明

シェルスクリプトを利用したパスワードマネージャーです。

## 使い方

- パスワードの暗号化ソフトとしてGnuPGを利用しているため、GnuPGのインストールが必要です。

1. `gpg`コマンドを試す

```console
-> gpg
gpg: WARNING: no command supplied.  Trying to guess what you mean ...
gpg: Go ahead and type your message ...
## Ctrl + C で中断できます
```

上記の警告メッセージが表示される場合は、GnuPGが導入済みであるため、2.のインストール手順は不要です。

2. GnuPGのインストール

```console
-> sudo apt install gnupg
## パッケージ管理ツールによりコマンドは異なります
```

`gpg`コマンドが利用可能な状態になりましたら、パスワードマネージャーが利用できます。

3. シェルスクリプトの実行

```console
-> ./password_manager.sh
```

- ※シェルスクリプトの実行権限がない場合は、実行権限を付与します

```console
-> chmod u+x password_manager.sh
```
