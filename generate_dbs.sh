#!/bin/bash

file=$1
if [[ -z $file ]]; then
  file='repos.txt'
fi
mkdir dbs

cat "$file" | while read -r line; do
  repo=$(echo "$line" | awk '{print $NF}')
  extensions=$(echo "$line" | awk '{print $1}')

  echo "Repo: $repo"
  echo "Extensions: $extensions"

  folder=$(basename "$repo")
  git clone -q "$repo" "$folder"
  cp .archstatsignore "$folder"/.archstatsignore
  archstats export sqlite "dbs/$folder".db \
            -f "$folder" \
            -e indentations \
            -e "$extensions"

  rm -rf "$folder"
  echo "---"
done

echo "Done"
