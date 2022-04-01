# Global git hooks

## この global git hooks のウリ

この global hook は作業リポジトリ配下の hook も global hook の後呼び出されるため上書きや実行漏れの心配がない

## Setup

このディレクトリを clone して必要ファイルをコピー

```sh
git clone https://github.com/amabie-mamoru/global-git-hooks.git
cp -ri hooks ~/.config/git/
```

global な設定として書き込む

```sh
git config --global core.hooksPath ~/.config/git/hooks
```

## hook の作り方

pre-commit を参考に解説する

hooks/pre-commit に記載されている `_read_global_hooks` の引数に合わせたディレクトリを作る

※この引数名を変更することで任意のディレクトリにすることが可能

```sh
!/bin/sh

GLOBAL_HOOK_ROOT=${HOME}/.config/git/hooks
sh ${GLOBAL_HOOK_ROOT}/_read_global_hooks pre-commits # <- この引数名のディレクトリを作る
sh ${GLOBAL_HOOK_ROOT}/_read_local_hooks
```

今回はデフォルトで pre-commits としていたのでそのディレクトリを作る

```sh
mkdir hooks/pre-commits
```

あとは pre-commit 時の hook を追記する

一例として以下のようなファイルを作る

```sh
echo "hoge" >> hooks/pre-commits/echo-hoge.sh
```

実行権限を付与する

```sh
chmod +x hooks/pre-commits/echo-hoge.sh
```

global hook として反映する

```sh
cp -ri hooks ~/.config/git/
```

これで適当なリポジトリ配下にいき、 commit しようとすると hoge が表示される

実行結果サンプル

```sh
# 任意のリポジトリまで移動後
echo "tmp" >> tmp.txt
git add tmp.txt
git commit -m 'commit message'
hoge # <- ここに出力される
[fix/aaa cb5f4e6fdfc] commit message
```

## おまけ

`feature/sample` ブランチにてサンプルが確認できる

[pre-commit hook サンプル](https://github.com/amabie-mamoru/global-git-hooks/blob/feature/sample/hooks/pre-commits/confirm-branch.sh)

