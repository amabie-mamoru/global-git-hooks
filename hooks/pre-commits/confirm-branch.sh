#!/bin/sh

# サンプル

branch_name=`git branch --show-current`

echo "ほんまに ${branch_name} ってブランチにコミット足してええか？(y/n [y]) "
exec < /dev/tty
read answer

case $answer in
    'n' | 'N') exit 0;;
    * ) ;;
esac

echo "コミットしないで置いてやるから新しくブランチ切りな！"
exit 1

