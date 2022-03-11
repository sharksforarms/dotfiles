#!/bin/sh

curl -o bfg.jar https://repo1.maven.org/maven2/com/madgag/bfg/1.13.2/bfg-1.13.2.jar

BFG=$PWD/bfg.jar

rm -rf /tmp/dotfiles.git
cd /tmp/
git clone --mirror git@bitbucket.org:sharksforarms/dotfiles.git
cd /tmp/dotfiles.git

java -jar $BFG --delete-files rust-analyzer
java -jar $BFG --delete-files gopls.tar.gz
java -jar $BFG --delete-files nvim
java -jar $BFG --delete-folders plugged

git reflog expire --expire=now --all && git gc --prune=now --aggressive
